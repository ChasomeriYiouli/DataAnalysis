import pyodbc

CONNECTION = pyodbc.connect('DRIVER={SQL Server};\
                            SERVER=DESKTOP-7D4VVHJ\SQLPAULINA;\
                            DATABASE=TEAMPROJECT;\
                            Trusted_Connection=yes;')

cursor = CONNECTION.cursor()
# cursor.execute("select @@version")
# rows = cursor.fetchall()
# print (rows)

CONNECTION_DW =pyodbc.connect('DRIVER={SQL Server};\
                            SERVER=DESKTOP-7D4VVHJ\SQLPAULINA;\
                            DATABASE=TEAMPROJECT_DW;\
                            Trusted_Connection=yes;')

cursor2 = CONNECTION_DW.cursor()