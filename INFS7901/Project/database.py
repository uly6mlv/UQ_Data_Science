
import pymysql

class Database:
    def connect(self):
        return pymysql.connect(host='localhost',
                             user='uly6mlv',
                             password='1234',
                             db='supermarket')

    def read(self, id, line):
        con = Database.connect(self)
        cursor = con.cursor()

        try:
            if id == None:
                cursor.execute("SELECT OrderNumber, OrderDate, StockDate, ProductID, CustomerID, "
                               "TerritoryID, OrderLineItem, OrderQuantity FROM sales")
            else:
                cursor.execute("SELECT OrderNumber, OrderDate, StockDate, ProductID, CustomerID, "
                               "TerritoryID, OrderLineItem, OrderQuantity FROM sales where OrderNumber = %s AND OrderLineItem = %s", (id,line,))

            return cursor.fetchall()
        except:
            return ()
        finally:
            con.close()

    def insert(self,data):
        con = Database.connect(self)
        cursor = con.cursor()

        try:
            cursor.execute("INSERT INTO sales(OrderNumber, OrderDate, StockDate, ProductID, CustomerID, TerritoryID, "
                           "OrderLineItem, OrderQuantity) VALUES(%s, %s, %s, %s, %s, %s, %s, %s)",
                           (data['OrderNumber'],data['OrderDate'],data['StockDate'],
                            data['ProductID'],data['CustomerID'],data['TerritoryID'],data['OrderLineItem'],
                            data['OrderQuantity'],))
            con.commit()

            return True
        except:
            con.rollback()

            return False
        finally:
            con.close()

    def update(self, id, line, data):
        con = Database.connect(self)
        cursor = con.cursor()

        try:
            cursor.execute("UPDATE sales set OrderDate = %s, StockDate = %s, ProductID = %s, CustomerID = %s, TerritoryID = %s, OrderQuantity = %s where OrderNumber = %s AND OrderLineItem = %s", (data['OrderDate'],data['StockDate'],
                            data['ProductID'],data['CustomerID'],data['TerritoryID'],
                            data['OrderQuantity'],id,line,))
            con.commit()

            return True
        except:
            con.rollback()

            return False
        finally:
            con.close()

    def delete(self, id, line):
        con = Database.connect(self)
        cursor = con.cursor()

        try:
            cursor.execute("DELETE FROM sales where OrderNumber = %s AND OrderLineItem = %s", (id,line,))
            con.commit()

            return True
        except:
            con.rollback()

            return False
        finally:
            con.close()
