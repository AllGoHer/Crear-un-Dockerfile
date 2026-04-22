# Crear-un-Dockerfile ![image](https://github.com/user-attachments/assets/7acb25f6-06a3-42d0-848b-568053a0372d)  ![image](https://github.com/user-attachments/assets/e9627195-c862-4415-98b8-9ff9a371d8bb)
____________________________________________________________________________________________________________________________________________________________________________________________________________

En este proyecto veremos como crear correctamente el archivo Dockerfile, cuidando detalles importantes como el nombre sin extensión y la estructura básica del código. A partir de ahí, trabajamos con una imagen basada en N8N, configurando el mantenedor, el puerto 5678 y el protocolo HTTP para que el contenedor quede listo para usarse. Luego construimos la imagen desde la terminal con el comando docker build, entendiendo qué significa cada parámetro como el uso de no cache, el nombre de la imagen y la versión 2.16.

Después convertimos esa imagen en un contenedor en ejecución, exponiendo el puerto correspondiente y verificando que todo esté funcionando tanto desde la terminal como desde Docker Desktop. Finalmente, comprobamos que N8N está corriendo correctamente accediendo desde el navegador en localhost:5678.

## PASOS
_______________________________________________________________________________________________________________________________________________________________________________________________________________

CREAR UN DOCKERFILE
1.	Creamos un archivo de texto llamado Dockerfile en mis archivos de documentos.
 
![image](https://github.com/user-attachments/assets/41032f23-8464-465c-976e-65a80ec6f45b)

2.	Abrimos el archivo y le agregamos los siguientes datos:

FROM n8nio/n8n:latest              
LABEL maintainer="Allan <allangonzales1221@gmail.com”
EXPOSE 5678
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV N8N_PROTOCOL=http

Donde: 
•	FROM n8nio/n8n:latest -- # Está trayendo la última versión de n8n          
•	LABEL maintainer="Allan <allangonzales1221@gmail.com”  -es la etiqueta de quien esta dando mantenimiento. Ahí deben cambiar los datos por su cuenta personal de correo electrónico.
•	EXPOSE 5678  - va mostrar dentro del contenedor el puerto 5678 
•	ENV N8N_HOST=0.0.0.0   -- cualquier IP se conecte lo va a recibir.
•	ENV N8N_PORT=5678  --- el puerto que va tener n8n.
•	ENV N8N_PROTOCOL=http  -- es el protocolo con el que va a trabajar (http).

3.	Ahora nos dirigimos a la carpeta donde esta nuestro archivo dockerfile, luego haz clcik en la barra de direcciones (arriba) y escribe cmd y presiona enter.
 
 ![image](https://github.com/user-attachments/assets/ca7282ff-a39b-4b72-9864-8b07e90b062e)

 ![image](https://github.com/user-attachments/assets/b656573b-7283-4f7e-b0f5-7a66cc903628)

4.	CREAR LA IMAGEN
   Se creará la imagen con el siguiente comando:

  	docker build --no-cache -t mi-n8n:2.16 .
  	
•	Docker build  -- buid indica que va construir una imagen a partir de nuestro Dockerfile.
•	--no-cache   -- que no use cache, haciendo más rápida la creación de la imagen.
•	-t mi-n8n:   -- nombre de la imagen.
•	2.16 .  -- indica la versión de n8n y, el puntito final despues de un espacio, indica que busque dentro de la carpeta que estamos trabajando el archivo dockerfile.

![image](https://github.com/user-attachments/assets/a1ae3c75-4c66-492b-b365-3091cefa2db6)

 •	Si al ejecutarlo sale como error, vuelve a verificar que el archivo Dockerfile que creaste no tenga extensión (.txt), a pesar, que no lo veas la extensión txt, Windows suele ocultarlo.

 ![image](https://github.com/user-attachments/assets/8a672318-bb27-464e-82cb-012c9a1d9e30)
 
Causa 1: Tienes ocultas las extensiones de archivo (La más probable)
Cuando creas un archivo de texto en Windows y le pones "Dockerfile", Windows en realidad lo nombra Dockerfile.txt. Docker es muy estricto y exige que se llame exactamente Dockerfile sin ninguna extensión.

Cómo comprobarlo y arreglarlo:

Ve a la carpeta C:\Users\User\Documents\Docker en el explorador de archivos de Windows.
Arriba, en la pestaña "Ver", activa la casilla que dice "Extensiones de nombres de archivo".
Verás que tu archivo probablemente se llama Dockerfile.txt.
Renómbralo a simplemente Dockerfile (te saldrá una advertencia de Windows, dile que sí).




5.	Comprobamos si la imagen ya fue creada con: docker image ls

   ![image](https://github.com/user-attachments/assets/ba4539ad-07cc-40a2-b438-e25c964d43fa)
 
También podemos verlo en Docker desktop con el nombre mi-n8n

  ![image](https://github.com/user-attachments/assets/121977d9-8647-4a7e-a88c-b6cbc84831ba)
 
6.	CREAR EL CONTENEDOR A PARTIR DE LA IMAGEN, con el siguiente comando 

docker run -d --name n8n-server -p 5678:5678 -v n8n_data:/home/node/.n8n mi-n8n:1.0 

6.1.	Docker -- voy a usar Docker para hacer algo.
6.2.	Run -- Es la acción. Significa: "Toma una imagen (una plantilla) y créame un contenedor (una máquina virtual ligera) a partir de ella y enciéndelo".
6.3.	-d --(Detached), Significa "Despegado" o en segundo plano.
Qué hace: Si no pones esta bandera, el contenedor se apodera de tu terminal. Verás los logs (textos) del programa pasar a toda velocidad y no podrás escribir más comandos en esa ventana. Al poner -d, Docker lanza el contenedor y te devuelve el control de la terminal inmediatamente, dejando el programa corriendo silenciosamente de fondo.
6.4.	--name n8n-server ---- Asignar un nombre personalizado.
Qué hace: Por defecto, Docker le pone nombres aleatorios y graciosos a los contenedores (como sleepy_einstein o crazy_tesla). Si no le pones nombre, para detenerlo mañana tendrías que escribir un código largo feo (el ID del contenedor). Al poner --name n8n-server, te aseguras de que mañana puedas detenerlo fácilmente escribiendo: docker stop n8n-server.

6.5.	-p 5678:5678 (Publish / Mapeo de Puertos)
Esta es la parte más importante de Docker. Se lee como Puerto_Host: Puerto_Contenedor.

Qué hace: El contenedor es como una casa cerrada. n8n por defecto trabaja en el puerto 5678, pero ese puerto vive dentro de la casa de Docker. Tu navegador web (en tu Windows/Mac) no puede entrar a esa casa.
El primer 5678 (Izquierda): Es tu computadora real. Le dice a Windows: "Abre el puerto 5678 en mi red local".
El segundo 5678 (Derecha): Es el interior del contenedor. Le dice a Docker: "Lo que entre por tu puerto 5678, envíalo al puerto 5678 del contenedor".

Resultado: Te permite abrir tu navegador en http://localhost:5678 y ver n8n. (Nota: Podrías hacerlo -p 8080:5678, y entonces entrarías por el 8080 en tu navegador).

6.6.	-v n8n_data:/home/node/.n8n (Volume / Volumen)
Esta es la bandera que salva vidas. Se lee como Nombre_Volumen : Ruta_Dentro_Contenedor.

El problema que resuelve: Los contenedores son efímeros (temporales). Si creas un flujo de trabajo en n8n y luego borras el contenedor (o lo reinicias de cierta forma), pierdes todo tu trabajo. Los datos mueren con el contenedor.
Qué hace: Crea una carpeta especial en tu computadora real llamada n8n_data y la "engancha" a la carpeta donde n8n guarda su configuración (/home/node/.n8n).

Resultado: Todo lo que guardes en n8n se escribirá directamente en tu computadora real. Si el contenedor explota o lo borras, al volver a correr este comando, n8n leerá esa carpeta y todos tus flujos seguirán ahí intactos.

6.7.	mi-n8n:2.16 (La Imagen)
Es la "receta" que acabas de crear en tu pregunta anterior con el docker build.

mi-n8n: El nombre de la imagen.
:2.16: La etiqueta (versión). Le dice a Docker: "No uses la última versión que esté en internet, usa exactamente la versión 2.16 que yo acabo de compilar en mi computadora".
 
![image](https://github.com/user-attachments/assets/2f58ce01-2b61-479d-9e55-7d2f07e8bf1b)

En resumen (Traducción a español coloquial):
"Docker, corre una máquina en segundo plano, llámala n8n-server, conecta el puerto 5678 de mi PC al puerto 5678 de la máquina, guarda todo lo que haga la máquina en una carpeta segura llamada n8n_data, y haz todo esto usando la versión 2.16 de la imagen que yo construí".

•	ahora podemos ver el contenedor corriendo en la terminal y en Docker Desktop, escribiendo el siguiente comando: Docker ps

  ![image](https://github.com/user-attachments/assets/a35de840-36f0-46cf-b50a-c9c41bf2af77)
  ![image](https://github.com/user-attachments/assets/3906234d-c57f-4034-8fe1-d314629f6512)
   
•	Finalmente hacemos click en el puerto 5678:5678 para verlo en loclahost del navegador.
 
   ![image](https://github.com/user-attachments/assets/7e874f26-6be2-4f01-a7d0-7bf04a0aba42)

   ![image](https://github.com/user-attachments/assets/a2d1994c-39c7-4cc9-8389-28946ca28697)
 
