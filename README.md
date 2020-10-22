# Golang conexión con oracle 12c
Basado en oracle docker-images https://github.com/oracle/docker-images/tree/master/OracleInstantClient/dockerfiles/12.2.0.1

Sigua los siguientes pasos
### 

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
