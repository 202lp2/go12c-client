# Golang conexión con oracle 12c
Basado en oracle docker-images https://github.com/oracle/docker-images/tree/master/OracleInstantClient/dockerfiles/12.2.0.1

Sigua los siguientes pasos
##En un contenedor docker 

1. Con powershell construya el contenedor

	PS D:\dockr\lp2\go12c> docker-compose up --build -d

	PS D:\dockr\lp2\go12c> docker ps -a

### 
2. Ingrese al contenedor

	PS D:\dockr\lp2\go12c> docker exec -it go12c_app bash

	bash-4.2# go version

	bash: go: command not found

	bash-4.2# 

###
3. Queda instalar golang
para ello descargar golang para linux de https://golang.org/dl/ 
pegar en la carpeta `goapp` para que copia al contenedor
y ejecute los siguientes comandos:

	bash-4.2# tar -C /usr/local -xzf /usr/local/go1.15.3.linux-amd64.tar.gz

	bash-4.2# export PATH=$PATH:/usr/local/go/bin 

	bash-4.2# go version

###
4. Ejecute la aplicación que conecta con oracle 12c
debes tener una tabla y modifica el archivo main.go de ser necesario

	bash-4.2# cd usr/local/

	bash-4.2# go run main.go egibide/12345Abcde@localhost:1521/ORCLCDB

	Successful 'as sysdba' connection. Current user is: ELENA
	
	bash-4.2#

###
* En caso de no conectar debe salir los siguiente:

	ORA-12541: TNS:no listener
	
	deberás iniciar el servico del oracle db o revisar la cadena de conexión


## En windows, sin contenedor docker

1. Necesitas una base de datos oralce

	a. Descargar el contenedor para oracle db server, por ejemplo https://github.com/ijaureguialzo/oracle12c

	b. Una db en amazon

	c. instalar en su equipo

2. Verifique el servicio
	
	para el caso a. ingrese al contenedor

	> docker exec -it oracle_server bash

	oracle@ed56135c0040 /]$ sqlplus sys/Oradoc_db1 as SYSDBA

	SQL*Plus: Release 12.2.0.1.0 Production on Thu Oct 22 05:35:14 2020


	Copyright (c) 1982, 2016, Oracle.  All rights reserved.


	Connected to:
	Oracle Database 12c Enterprise Edition Release 12.2.0.1.0 - 64bit Production

	SQL>  show parameter service_names

	NAME                                 TYPE        VALUE
	------------------------------------ ----------- ------------------------------
	service_names                        string      ORCLCDB.localdomain
	SQL>                                                                    


3. Descargar el ejemplo de https://github.com/202lp2/go12c-client (no vamos usar docker)

4. Configurar el cliente de oracle en la unidad C:\instantclient_12_2
	descargar y descomprimir

	seguir este manual https://medium.com/@utranand/how-to-connect-golang-to-oracle-on-windows-64-bit-using-go-oci8-library-ab9ed0511b20
	solo que en vez de C:\MinGW usar msys2 pero instalar en C:\msys64 luego todo igual

	instantclient-basic-windows.x64-12.2.0.1.0.zip
	instantclient-sdk-windows.x64-12.2.0.1.0.zip
	instantclient-sqlplus-windows.x64-12.2.0.1.0.zip

	renombre el archivo `oci8 para windows.pc` a `oci8.pc` (o usar el mismo `oci8.pc` de la raiz del repositorio)  y pegarlo dentro de C:\instantclient_12_2

	setx PKG_CONFIG_PATH "C:\instantclient_12_2"

	en el path agregar:

	C:\instantclient_12_2
	
	C:\msys64\mingw64\bin
	
	C:\pkg-config\bin



	instalar el MSYS2 https://www.msys2.org/
	y ejecutar
	Asullom@DESKTOP-7VTV5IP MSYS ~
	$ pacman -S mingw64/mingw-w64-x86_64-pkg-config mingw64/mingw-w64-x86_64-gcc


5. Ejecutar 

	PS D:\dockr\lp2\go12c\goapp> go run main.go sys/Oradoc_1@localhost:1521/orclcdb.localdomain?as=SYSDBA

	ORA-00942: table or view does not exist

	PS D:\dockr\lp2\go12c\goapp> go run main.go egibide/12345Abcde@localhost:1521/ORCLCDB.localdomain

	Successful 'as sysdba' connection. Current user is: ww
	PS D:\dockr\lp2\go12c\goapp>





