CREATE DATABASE IF NOT EXISTS financial_management;

USE financial_management;

-- staff table: contains the information of staff, including name, id, and password)
CREATE TABLE staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    s_password VARCHAR(255),
    name VARCHAR(255),
    position VARCHAR(100)
);

-- create customer table containing the customer information
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    contact_info VARCHAR(255),
    risk_tolerance_level VARCHAR(50),
    advisor_id INT,
    FOREIGN KEY (advisor_id) REFERENCES staff(staff_id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);

-- accounts table: contains account_id, customer id, opening date
CREATE TABLE accounts (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(100),
    opening_date DATE,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

-- asset table records the information of asset
CREATE TABLE assets (
    asset_id INT AUTO_INCREMENT PRIMARY KEY,
    details TEXT
);

-- transaction table records the transaction history
CREATE TABLE transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT,
    asset_id INT,
    quantity INT,
    price DECIMAL(10, 2) CHECK (price >= 0),
    transaction_date DATE,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
    FOREIGN KEY (asset_id) REFERENCES assets(asset_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

-- client activity table: record the interactions between staff and clients. 
-- This table is used to improve client services and coordinate internal management.
CREATE TABLE client_activity (
    activity_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    staff_id INT,
    description TEXT,
    date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

-- Create investment reviews table that contains the periodic review records of clients' accounts.
-- This is ued to monitor and evaluate the investment performance, and investment recommendations
CREATE TABLE investment_reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT,
    review_date DATE,
    comments TEXT,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

-- market data table contains the market data of trading assets
-- used to perform market analysis and form trading strategies
CREATE TABLE market_data (
    data_id INT AUTO_INCREMENT PRIMARY KEY,
    asset_id INT,
    date DATE,
    price DECIMAL(10, 2),
    volume INT,
    FOREIGN KEY (asset_id) REFERENCES assets(asset_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);


CREATE TABLE account_holdings (
    holding_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT,
    asset_id INT,
    quantity INT,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
    FOREIGN KEY (asset_id) REFERENCES assets(asset_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);


CREATE TABLE account_asset_relations (
    relation_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT,
    asset_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
    FOREIGN KEY (asset_id) REFERENCES assets(asset_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

-- create financial reports table
-- financial reports focus more on the client's financial data and analysis
-- Investment reviews focus on periodic investment evaluation and Strategy adjustment suggestions
CREATE TABLE financial_reports (
    report_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT,
    report_date DATE,
    content TEXT,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);


CREATE TABLE staff_customer_relations (
    relation_id INT AUTO_INCREMENT PRIMARY KEY,
    staff_id INT,
    customer_id INT,
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

-- record the change history of account changes.
-- For internal control purposes.
CREATE TABLE account_changes_log (
    change_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT,
    previous_type VARCHAR(100),
    new_type VARCHAR(100),
    change_date DATETIME,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);



-- database programming
-- add new clients
DELIMITER //

CREATE PROCEDURE AddNewCustomer(IN p_name VARCHAR(255), IN p_contact_info VARCHAR(255), IN p_risk_tolerance_level VARCHAR(50), IN p_advisor_id INT)
BEGIN
    INSERT INTO customers (name, contact_info, risk_tolerance_level, advisor_id) 
    VALUES (p_name, p_contact_info, p_risk_tolerance_level, p_advisor_id);
END //

DELIMITER ;

-- update client info
DELIMITER //

CREATE PROCEDURE UpdateCustomer(
    IN p_customer_id INT,
    IN p_name VARCHAR(255),
    IN p_contact_info VARCHAR(255),
    IN p_risk_tolerance_level VARCHAR(50),
    IN p_advisor_id INT
)
BEGIN
    UPDATE customers
    SET
        name = IF(p_name IS NOT NULL AND p_name != '', p_name, name),
        contact_info = IF(p_contact_info IS NOT NULL AND p_contact_info != '', p_contact_info, contact_info),
        risk_tolerance_level = IF(p_risk_tolerance_level IS NOT NULL AND p_risk_tolerance_level != '', p_risk_tolerance_level, risk_tolerance_level),
        advisor_id = IF(p_advisor_id IS NOT NULL AND p_advisor_id != 0, p_advisor_id, advisor_id)
    WHERE customer_id = p_customer_id;
END //

DELIMITER ;


-- delete client records
DELIMITER //

CREATE TRIGGER BeforeCustomerDelete
BEFORE DELETE ON customers
FOR EACH ROW
BEGIN
    DELETE FROM client_activity WHERE customer_id = OLD.customer_id;
    DELETE FROM transactions WHERE account_id IN (SELECT account_id FROM accounts WHERE customer_id = OLD.customer_id);
    DELETE FROM account_holdings WHERE account_id IN (SELECT account_id FROM accounts WHERE customer_id = OLD.customer_id);
    DELETE FROM investment_reviews WHERE account_id IN (SELECT account_id FROM accounts WHERE customer_id = OLD.customer_id);
    DELETE FROM financial_reports WHERE account_id IN (SELECT account_id FROM accounts WHERE customer_id = OLD.customer_id);
    DELETE FROM accounts WHERE customer_id = OLD.customer_id;
    DELETE FROM staff_customer_relations WHERE customer_id = OLD.customer_id;

END //

DELIMITER ;


-- record account changes
DELIMITER //

CREATE TRIGGER AfterAccountUpdate
AFTER UPDATE ON accounts
FOR EACH ROW
BEGIN
    INSERT INTO account_changes_log (account_id, previous_type, new_type, change_date)
    VALUES (NEW.account_id, OLD.type, NEW.type, NOW());
 
END //

DELIMITER ;

-- execute transactions
DELIMITER //

CREATE PROCEDURE ExecuteTransaction(
    IN p_account_id INT, 
    IN p_asset_id INT, 
    IN p_quantity INT, 
    IN p_price DECIMAL(10, 2)
)
BEGIN
	DECLARE current_quantity INT DEFAULT 0;
	-- check whether price > 0
    IF p_price < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Price cannot be negative';
        
    END IF;
        
	-- get asset quantity and check whether selling is feasible 
    SELECT quantity INTO current_quantity
    FROM account_holdings
    WHERE account_id = p_account_id AND asset_id = p_asset_id;
    IF p_quantity < 0 AND ABS(p_quantity) > current_quantity THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient Asset to Sell';
    END IF;
    
    INSERT INTO transactions (account_id, asset_id, quantity, price, transaction_date) 
    VALUES (p_account_id, p_asset_id, p_quantity, p_price, NOW());

    -- check whether the accounts have the asset
    IF EXISTS (SELECT * FROM account_holdings WHERE account_id = p_account_id AND asset_id = p_asset_id) THEN
        UPDATE account_holdings
        SET quantity = quantity + p_quantity 
        WHERE account_id = p_account_id AND asset_id = p_asset_id;
    ELSE
        INSERT INTO account_holdings (account_id, asset_id, quantity)
        VALUES (p_account_id, p_asset_id, p_quantity);
    END IF;

    COMMIT;
END //

DELIMITER ;


-- update market data
DELIMITER //

CREATE PROCEDURE UpdateMarketData(IN p_data_id INT, IN p_price DECIMAL(10, 2), IN p_volume INT)
BEGIN
    UPDATE market_data
    SET price = p_price, volume = p_volume
    WHERE data_id = p_data_id;
END //

DELIMITER ;

-- add market data
DELIMITER //

CREATE PROCEDURE AddMarketData(IN p_asset_id INT, IN p_date DATE, IN p_price DECIMAL(10, 2), IN p_volume INT)
BEGIN
    INSERT INTO market_data (asset_id, date, price, volume) 
    VALUES (p_asset_id, p_date, p_price, p_volume);
END //

DELIMITER ;

-- delete market data
DELIMITER //

CREATE PROCEDURE DeleteMarketData(IN p_data_id INT)
BEGIN
    DELETE FROM market_data
    WHERE data_id = p_data_id;
END //

DELIMITER ;




