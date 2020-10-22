# Golang conexión con oracle 12c

Elija una de las 2 opciones 


## En un contenedor docker 

Basado en oracle docker-images https://github.com/oracle/docker-images/tree/master/OracleInstantClient/dockerfiles/12.2.0.1

1. Con powershell construya el contenedor

> 

	PS D:\dockr\lp2\go12c> docker-compose up --build -d

	PS D:\dockr\lp2\go12c> docker ps -a

### 
2. Ingrese al contenedor

> 

	PS D:\dockr\lp2\go12c> docker exec -it go12c_app bash

	bash-4.2# go version

	bash: go: command not found

	bash-4.2# 

###
3. Queda instalar golang
para ello descargar golang para linux de https://golang.org/dl/ 
pegar en la carpeta `goapp` para que copia al contenedor
y ejecute los siguientes comandos:

> 

	bash-4.2# tar -C /usr/local -xzf /usr/local/go1.15.3.linux-amd64.tar.gz

	bash-4.2# export PATH=$PATH:/usr/local/go/bin 

	bash-4.2# go version

###
4. Ejecute la aplicación que conecta con oracle 12c
debes tener una tabla y modifica el archivo main.go de ser necesario

> 

	bash-4.2# cd usr/local/

	bash-4.2# go run main.go egibide/12345Abcde@localhost:1521/ORCLCDB

	Successful 'as sysdba' connection. Current user is: ELENA
	
	bash-4.2#

###
* En caso de no conectar debe salir los siguiente:

> 

	ORA-12541: TNS:no listener
	
	deberás iniciar el servico del oracle db o revisar la cadena de conexión


## En windows, sin contenedor docker

1. Necesitas una base de datos oracle, puede ser :


	a. Descargar el contenedor para oracle db server, por ejemplo https://github.com/ijaureguialzo/oracle12c


	b. O una db orcle en amazon


	c. O instalar en su equipo el oracle server

	d. Otras ....


2. Verifique el servicio
	
	para el caso a. ingrese al contenedor, por ejemplo:

	
> 


	PS D:\dockr\lp2\varios\oracle12c> docker ps 


	CONTAINER ID        IMAGE                                            COMMAND                  CREATED             STATUS                  PORTS                                            NAMES

	ed56135c0040        store/oracle/database-enterprise:12.2.0.1-slim   "/bin/sh -c '/bin/ba…"   11 hours ago        Up 11 hours (healthy)   0.0.0.0:1521->1521/tcp, 0.0.0.0:5500->5500/tcp   oracle_server

	7b451a034c24        oracle/instantclient:12.2.0.1                    "/bin/sh -c bash"        15 hours ago        Up 15 hours             0.0.0.0:8082->8080/tcp                           go12c_app


	PS D:\dockr\lp2\varios\oracle12c> docker exec -it ed56135c0040 bash

	oracle@ed56135c0040 /]$ sqlplus sys/Oradoc_db1 as SYSDBA

	SQL*Plus: Release 12.2.0.1.0 Production on Thu Oct 22 05:35:14 2020



	Copyright (c) 1982, 2016, Oracle.  All rights reserved.


	Connected to:

	Oracle Database 12c Enterprise Edition Release 12.2.0.1.0 - 64bit Production

	SQL>  show parameter service_names

	NAME                                 TYPE        VALUE

	------------------------------------ ----------- ------------------------------

	service_names                        string      `ORCLCDB.localdomain`

	SQL>                                                                    


3. Descargar el ejemplo de https://github.com/202lp2/go12c-client (no vamos usar docker)
	o descargar solo los archivos \go12c\oci8.pc y \go12c\goapp\main.go, se recomienda descarga también el archivo go.mod 

	Puede continuar los pasos de manual https://medium.com/@utranand/how-to-connect-golang-to-oracle-on-windows-64-bit-using-go-oci8-library-ab9ed0511b20
	solo que en vez de C:\MinGW usar MSYS2 pero instalar en C:\msys64 luego todo igual
	o seguir con los pasos siguientes



4. Configurar el cliente de oracle la versión 12.2 en la unidad C:\instantclient_12_2

	Descargar : 

	https://www.oracle.com/database/technologies/instant-client/winx64-64-downloads.html 
	

	instantclient-basic-windows.x64-12.2.0.1.0.zip

	instantclient-sdk-windows.x64-12.2.0.1.0.zip

	instantclient-sqlplus-windows.x64-12.2.0.1.0.zip


	Extraer en:

	C:\instantclient_12_2



	Del paso 3, copiar el archivo `oci8.pc` en:


	C:\instantclient_12_2

	
	File oci8.pc at :

	C:\instantclient_12_2\oci8.pc



	Luego configure las variables de entorno:

	> 
	setx PKG_CONFIG_PATH "C:\instantclient_12_2"


	en el path agregar:

	C:\instantclient_12_2	
	
	C:\pkg-config\bin

	C:\msys64\mingw64\bin


5. Administrador de configuración de paquetes `pkg-config`:

	Descargar : 

	http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/pkg-config_0.26-1_win32.zip

	http://ftp.gnome.org/pub/gnome/binaries/win32/glib/2.28/glib_2.28.8-1_win32.zip

	http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/gettext-runtime_0.18.1.1-2_win32.zip

	
	Extraer en:

	 C: \pkg-config


6. Instalar el MSYS2
	
	Descargar : 
 	
 	https://www.msys2.org/

 	Instalar `msys2-x86_64-20200903.exe` en: (instalation folder)

	C: \msys64


	Ejecutar en MSYS2: 

	Asullom@DESKTOP-7VTV5IP MSYS ~

	$ pacman -S mingw64/mingw-w64-x86_64-pkg-config mingw64/mingw-w64-x86_64-gcc


7. Ejecutar (deberás tener almenos una tabla en tu base de datos oracle)

> 

	PS D:\dockr\lp2\go12c\goapp> go run main.go sys/Oradoc_1@localhost:1521/orclcdb.localdomain?as=SYSDBA

	ORA-00942: table or view does not exist

	PS D:\dockr\lp2\go12c\goapp> go run main.go egibide/12345Abcde@localhost:1521/ORCLCDB.localdomain

	Successful 'as sysdba' connection. Current user is: ww

	PS D:\dockr\lp2\go12c\goapp>





