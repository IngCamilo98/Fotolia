import mysql.connector
import pandas as pd
from mysql.connector import connect, Error
from datetime import datetime

def ETL_Table_CLientes():

    try:
        # Establecer la conexión con la base de datos
        conexion = mysql.connector.connect(user='root', 
                                    password='C@milo2023',
                                    host='localhost',
                                    database='Fotolia')
#-----------------------------------------------------------------------------------------------------
        #Cargar los datos del csv para modificarlos 
        df = pd.read_csv('/home/ftd/Documentos/Fotolia/Clientes.csv',index_col=False)

        df['Id_Clientes'] = df['Id_Clientes'].astype(int)
        df['Nombre'] = df['Nombre'].astype(str)
        df['Apellido'] = df['Apellido'].astype(str)
        df['Direccion'] = df['Direccion'].astype(str)
        df['Telefono'] = df['Telefono'].astype(str)
        df['Correo_Electronico'] = df['Correo_Electronico'].astype(str)
        df['Edad'] = df['Edad'].astype(int)
        df['Genero'] = df['Genero'].astype(str)

        #Funcion para que la columna Nombre del dataframe se vuelvan a mayusculas
        df['Nombre'] = df['Nombre'].apply(lambda x: x.upper())

        #Funcion para que la columna Nombre del dataframe se vuelvan a minusculas
        df['Correo_Electronico'] = df['Correo_Electronico'].apply(lambda x: x.lower())

        #Funcion para multiplicar por dos cada data de la columna edad
        df['Edad'] = df['Edad'].apply(lambda x: x * 2)
#----------------------------------------------------------------------------------------------------
        #Cargar los datos en la base fotolia en mysql
        # Crear un cursor para interactuar con la base de datos
        cursor = conexion.cursor()
        script1 = 'INSERT INTO Clientes (Id_Cliente,Nombre,Apellido,Direccion,Telefono,Correo_Electronico,Edad,Genero) VALUES (%s,%s,%s,%s,%s,%s,%s,%s)'

        for index, row in df.iterrows():
            script2 = [row['Id_Clientes'],row['Nombre'],row['Apellido'],row['Direccion'],row['Telefono'],row['Correo_Electronico'],row['Edad'],row['Genero']]
            cursor.execute(script1,script2)

        # Cerrar la conexión y el cursor
        conexion.commit()
        cursor.close()
        conexion.close()
    except Error as e:
        print(e)

def ETL_Table_Campañas():

    try:
        # Establecer la conexión con la base de datos
        conexion = mysql.connector.connect(user='root', 
                                    password='C@milo2023',
                                    host='localhost',
                                    database='Fotolia')
#---------------------------------------------------------------------------------
        #Cargar los datos del csv para modificarlos
        df = pd.read_csv('/home/ftd/Documentos/Fotolia/Campañas.csv')

        df['Id_Campaña'] = df['Id_Campaña'].astype(int)
        df['Nombre'] = df['Nombre'].astype(str)
        df['Publico_Objetivo'] = df['Publico_Objetivo'].astype(str)
        df['Canal_Comunicacion'] = df['Canal_Comunicacion'].astype(str)
        df['Alcance'] = df['Alcance'].astype(str)
        df['Costo'] = df['Costo'].astype(int)
        df['Efectividad'] = df['Efectividad'].astype(str)
        df['Fecha_Inicio'] = pd.to_datetime(df['Fecha_Inicio']).dt.strftime('%Y-%m-%d')
        df['Fecha_Finalizacion'] = pd.to_datetime(df['Fecha_Finalizacion']).dt.strftime('%Y-%m-%d')

        #Funcion para que la columna Nombre del dataframe se vuelvan a mayusculas
        df['Canal_Comunicacion'] = df['Canal_Comunicacion'].apply(lambda x: x.upper())

        #Funcion para que la columna Nombre del dataframe se vuelvan a minusculas
        df['Efectividad'] = df['Efectividad'].apply(lambda x: x.lower())

        print(df.dtypes)

        # Funcion para Conviertir el objeto datetime a un string en formato "aaaa-mm-dd"


#----------------------------------------------------------------------------------------------------
        #Cargar los datos en la base fotolia en mysql
        # Crear un cursor para interactuar con la base de datos
        cursor = conexion.cursor()
        script1 = 'INSERT INTO Campañas (Id_Campaña,Nombre,Publico_Objetivo,Canal_Comunicacion,Alcance,Costo,Efectividad,Fecha_Inicio, Fecha_Finalizacion) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s)'
        for index, row in df.iterrows():
            script2 = [row['Id_Campaña'],row['Nombre'],row['Publico_Objetivo'],row['Canal_Comunicacion'],row['Alcance'],row['Costo'],row['Efectividad'],row['Fecha_Inicio'],row['Fecha_Finalizacion']]
            cursor.execute(script1,script2)
        # Cerrar la conexión y el cursor
        conexion.commit()
        cursor.close()
        conexion.close()
    except Error as e:
        print(e)
#ETL_Table_CLientes()        
ETL_Table_Campañas()