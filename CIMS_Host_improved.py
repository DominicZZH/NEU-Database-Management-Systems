import pymysql
import matplotlib.pyplot as plt

d_name = None
d_password = None

def get_db_connection():
    return pymysql.connect(
        host='localhost',
        user= d_name,
        password= d_password,  
        database='financial_management',
        charset='utf8mb4',
        cursorclass=pymysql.cursors.DictCursor
    )

# verify the identity of staffs
def verify_staff(staff_id, password):
    try:
        connection = get_db_connection()
        with connection.cursor() as cursor:
            sql = "SELECT * FROM staff WHERE staff_id = %s AND s_password = %s"
            cursor.execute(sql, (staff_id, password))
            return cursor.fetchone() is not None
    except pymysql.MySQLError as e:
        print(f"Database error: {e}")
        return False
    finally:
        connection.close()

# Execute SELECT founction to sql database
def fetch_data(sql):
    try:
        connection = get_db_connection()
        with connection.cursor() as cursor:
            cursor.execute(sql)
            return cursor.fetchall()
    except pymysql.MySQLError as e:
        print(f"Database error: {e}")
        return []
    finally:
        connection.close()

# Display it to users
def display_data(data):
    for row in data:
        print(row)

# visualize the market data to user
def plot_market_data(asset_id):
    sql = f"SELECT date, price FROM market_data WHERE asset_id = {asset_id} ORDER BY date"
    data = fetch_data(sql)
    if not data:
        print("No market data found for asset ID:", asset_id)
        return

    dates = [row['date'] for row in data]
    prices = [row['price'] for row in data]

    plt.figure(figsize=(10, 6))
    plt.plot(dates, prices, marker='o')
    plt.title(f'Market Data for Asset ID {asset_id}')
    plt.xlabel('Date')
    plt.ylabel('Price')
    plt.grid(True)
    plt.xticks(rotation=45)
    plt.tight_layout()
    plt.show()

# Use the database programming objects to add new clients (CREATE)
def add_new_customer(name, contact_info, risk_tolerance_level, advisor_id):
    try:
        connection = get_db_connection()
        with connection.cursor() as cursor:
            sql = "CALL AddNewCustomer(%s, %s, %s, %s)"
            cursor.execute(sql, (name, contact_info, risk_tolerance_level, advisor_id))
            connection.commit()
            print("New customer added successfully.")
    except pymysql.MySQLError as e:
        print(f"Database error: {e}")
    finally:
        connection.close()

# Use the database programming objects to update clients info (UPDATE)
def update_customer(customer_id, name, contact_info, risk_tolerance_level, advisor_id):
    try:
        connection = get_db_connection()
        with connection.cursor() as cursor:
            sql = "CALL UpdateCustomer(%s, %s, %s, %s, %s)"
            cursor.execute(sql, (customer_id, name, contact_info, risk_tolerance_level, advisor_id))
            connection.commit()
            print("Customer updated successfully.")
    except pymysql.MySQLError as e:
        print(f"Database error: {e}")
    finally:
        connection.close()

# Delete customer info
def delete_customer(customer_id):
    try:
        connection = get_db_connection()
        with connection.cursor() as cursor:
            # check whether customer ID still exists
            sql_check = "SELECT * FROM customers WHERE customer_id = %s"
            cursor.execute(sql_check, (customer_id,))
            if cursor.fetchone() is None:
                print("Customer not found.")
                return

            # delete customer info
            sql_delete = "DELETE FROM customers WHERE customer_id = %s"
            cursor.execute(sql_delete, (customer_id,))
            connection.commit()
            print("Customer deleted successfully.")
    except pymysql.MySQLError as e:
        print(f"Database error: {e}")
    finally:
        connection.close()


# Use the database programming objects to execute transaction  
def execute_transaction(account_id, asset_id, quantity, price):
    try:
        connection = get_db_connection()
        with connection.cursor() as cursor:
            sql = "CALL ExecuteTransaction(%s, %s, %s, %s)"
            cursor.execute(sql, (account_id, asset_id, quantity, price))
            connection.commit()
            print("Transaction executed successfully.")
    except pymysql.MySQLError as e:
        print(f"Database error: {e}")
    finally:
        connection.close()

# Use the database programming objects to update market data (UPDATE)
def update_market_data(data_id, price, volume):
    try:
        connection = get_db_connection()
        with connection.cursor() as cursor:
            sql = "CALL UpdateMarketData(%s, %s, %s)"
            cursor.execute(sql, (data_id, price, volume))
            connection.commit()
            print("Market data updated successfully.")
    except pymysql.MySQLError as e:
        print(f"Database error: {e}")
    finally:
        connection.close()
# Use the database programming objects to create market data (CREATE)
def add_market_data(asset_id, date, price, volume):
    try:
        connection = get_db_connection()
        with connection.cursor() as cursor:
            sql = "CALL AddMarketData(%s, %s, %s, %s)"
            cursor.execute(sql, (asset_id, date, price, volume))
            connection.commit()
            print("Market data added successfully.")
    except pymysql.MySQLError as e:
        print(f"Database error: {e}")
    finally:
        connection.close()
# Use the database programming objects to delete market data (DELETE)
def delete_market_data(data_id):
    try:
        connection = get_db_connection()
        with connection.cursor() as cursor:
            sql = "CALL DeleteMarketData(%s)"
            cursor.execute(sql, (data_id,))
            connection.commit()
            print("Market data deleted successfully.")
    except pymysql.MySQLError as e:
        print(f"Database error: {e}")
    finally:
        connection.close()




def main():
    global d_name, d_password
    d_name = input('Please enter your database user name: ')
    d_password = input('Please enter your database password: ')

    try:
        connection = get_db_connection()
        connection.close()
        print("Database connection successful.\n")
    except pymysql.MySQLError as e:
        print(f"Unable to connect to the database: {e}")
        return  
    
    staff_id = input("Enter staff ID: ")
    password = input("Enter password: ")

    if verify_staff(staff_id, password):
        print("Login successful!\n")
        while True:
            print("Choose an option:")
            print("1: View Market Data")
            print("2: View Customer List")
            print("3: View Accounts")
            print("4: View Assets")
            print("5: View Transactions")
            print("6: View Staff-Customer Interactions")
            print("7: Visualize Market Data")
            print("8: Add New Clients")
            print("9: Update Current Clients")
            print("10: Delete Current Clients")
            print("11: Execute Transactions")
            print("12: Update Market Data")
            print("13: Add Market Data")
            print('14: Delete Market Data')
            print('15: Exit')

            choice = input("Enter your choice: ")

            if choice == '1':
                sql = "SELECT * FROM market_data"
                data = fetch_data(sql)
                display_data(data)
            elif choice == '2':
                sql = "SELECT * FROM customers"
                data = fetch_data(sql)
                display_data(data)
            elif choice == '3':
                sql = "SELECT * FROM accounts"
                data = fetch_data(sql)
                display_data(data)
            elif choice == '4':
                sql = "SELECT * FROM assets"
                data = fetch_data(sql)
                display_data(data)
            elif choice == '5':
                sql = "SELECT * FROM transactions"
                data = fetch_data(sql)
                display_data(data)
            elif choice == '6':
                sql = "SELECT * FROM client_activity"
                data = fetch_data(sql)
                display_data(data)
            elif choice == '7':
                asset_id = input("Enter asset ID to view market data chart: ")
                plot_market_data(asset_id)
            elif choice == '8':
                name = input("Enter customer name: ")
                contact_info = input("Enter contact info: ")
                risk_tolerance_level = input("Enter risk tolerance level: ")
                advisor_id = input("Enter advisor ID: ")
                add_new_customer(name, contact_info, risk_tolerance_level, advisor_id)
            elif choice == '9':
                customer_id = input("Enter customer ID to update: ") 
                name = input("Enter new name (leave blank to keep current): ") or None
                contact_info = input("Enter new contact info (leave blank to keep current): ") or None
                risk_tolerance_level = input("Enter new risk tolerance level (leave blank to keep current): ") or None
                advisor_id_input = input("Enter new advisor ID (leave blank to keep current): ")
                try:
                    advisor_id = int(advisor_id_input) if advisor_id_input else None
                except ValueError:
                    print("Invalid input for advisor ID. Please enter a valid number.")
                    advisor_id = None
                update_customer(customer_id, name, contact_info, risk_tolerance_level, advisor_id)
            elif choice == '10':
                customer_id = input("Enter customer ID to delete: ")
                delete_customer(customer_id)
            elif choice == '11':
                account_id = input("Enter account ID: ")
                asset_id = input("Enter asset ID: ")
                quantity = input("Enter quantity: ")
                price = input("Enter price: ")
                execute_transaction(account_id, asset_id, quantity, price)
            elif choice == '12':
                data_id = input("Enter market data ID to update: ")
                price = input("Enter new price: ")
                volume = input("Enter new volume: ")
                update_market_data(data_id, price, volume)
            elif choice == '13':
                asset_id = input("Enter asset ID for new market data: ")
                date = input("Enter date (YYYY-MM-DD): ")
                price = input("Enter price: ")
                volume = input("Enter volume: ")
                add_market_data(asset_id, date, price, volume)
            elif choice == '14':
                data_id = input("Enter market data ID to delete: ")
                delete_market_data(data_id)
            elif choice == '15':
                break
            else:
                print("Invalid choice. Please try again.")
    else:
        print("Invalid staff ID or password.")

if __name__ == "__main__":
    main()
