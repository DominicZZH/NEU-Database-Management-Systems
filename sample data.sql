use financial_management;

-- import data to staff
INSERT INTO staff (s_password, name, position) VALUES 
('password123', 'John Doe', 'Financial Advisor'),
('password456', 'Jane Smith', 'Investment Manager'),
('password789', 'Alice Johnson', 'Account Manager');

-- import data to customer table 
INSERT INTO customers (name, contact_info, risk_tolerance_level, advisor_id) VALUES 
('Bob Brown', 'bob@example.com', 'Moderate', 1),
('Sara Davis', 'sara@example.com', 'High', 2),
('Mike Wilson', 'mike@example.com', 'Low', 3);


-- import data to accounts
INSERT INTO accounts (type, opening_date, customer_id) VALUES 
('Savings', '2021-01-10', 1),
('Checking', '2021-02-15', 2),
('Investment', '2021-03-20', 3);


-- import data to assets
INSERT INTO assets (details) VALUES 
('Stocks - Tech Companies'),
('Bonds - Government'),
('Real Estate Investment Trusts');

-- import data to transactions table
INSERT INTO transactions (account_id, asset_id, quantity, price, transaction_date) VALUES 
(1, 1, 10, 150.00, '2021-03-01'),
(2, 2, 5, 200.00, '2021-03-02'),
(3, 3, 2, 500.00, '2021-03-03');

-- import data client activity
INSERT INTO client_activity (customer_id, staff_id, description, date) VALUES 
(1, 1, 'Portfolio Review', '2021-04-01'),
(2, 2, 'Investment Strategy Meeting', '2021-04-02'),
(3, 3, 'Account Setup', '2021-04-03');

-- import data staff_client interaction data
INSERT INTO client_activity (customer_id, staff_id, description, date) VALUES 
(1, 1, 'Investment Discussion', '2023-01-03'),
(2, 1, 'Portfolio Review', '2023-01-04'),
(3, 2, 'Account Setup', '2023-01-05'),
(1, 2, 'Risk Assessment', '2023-01-06'),
(2, 3, 'Investment Plan Update', '2023-01-07'),
(3, 3, 'Regular Check-in', '2023-01-08');

-- import market data
INSERT INTO market_data (asset_id, date, price, volume) VALUES 
(1, '2023-01-01', 100.00, 500),
(1, '2023-01-02', 102.00, 450),
(1, '2023-01-03', 101.50, 400),
(1, '2023-01-04', 103.00, 420),
(1, '2023-01-05', 104.00, 510),
(1, '2023-01-06', 103.50, 460),
(1, '2023-01-07', 102.50, 480),
(1, '2023-01-08', 105.00, 500),
(1, '2023-01-09', 106.00, 520),
(1, '2023-01-10', 107.00, 510),

(2, '2023-01-01', 200.00, 200),
(2, '2023-01-02', 198.00, 300),
(2, '2023-01-03', 197.00, 250),
(2, '2023-01-04', 199.00, 280),
(2, '2023-01-05', 201.00, 300),
(2, '2023-01-06', 200.50, 310),
(2, '2023-01-07', 202.00, 320),
(2, '2023-01-08', 203.00, 330),
(2, '2023-01-09', 204.00, 340),
(2, '2023-01-10', 205.00, 350),

(3, '2023-01-01', 50.00, 1000),
(3, '2023-01-02', 49.50, 1500),
(3, '2023-01-03', 48.00, 1400),
(3, '2023-01-04', 48.50, 1300),
(3, '2023-01-05', 49.00, 1200),
(3, '2023-01-06', 50.50, 1100),
(3, '2023-01-07', 51.00, 1150),
(3, '2023-01-08', 51.50, 1200),
(3, '2023-01-09', 52.00, 1250),
(3, '2023-01-10', 53.00, 1300);

