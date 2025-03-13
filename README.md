# Proyecto de Streaming en Vivo con Nginx-RTMP

Este proyecto permite transmitir video en vivo utilizando **Nginx** con el módulo **RTMP**. Además, se ofrece soporte para **HLS (HTTP Live Streaming)** para reproducir la transmisión en navegadores mediante un reproductor web.

## Características

- **Transmisión RTMP:** Configuración del servidor para recibir flujos RTMP en el puerto 1935.
- **HLS:** Conversión del flujo RTMP a HLS, permitiendo la reproducción en tiempo real con un reproductor HTML5.
- **Servidor HTTP:** Se expone un servidor HTTP en el puerto 8080 para servir la página de reproducción y los archivos HLS.
- **Dockerizado:** Se utiliza un `Dockerfile` y `docker-compose.yml` para facilitar la construcción y despliegue del contenedor.

## Estructura del Proyecto

- **docker-compose.yml:** Define el servicio `nginx-rtmp` que construye la imagen a partir del `Dockerfile`, mapea los puertos necesarios y monta los volúmenes para la configuración de Nginx y la página web.
- **Dockerfile:** 
  - Basado en Ubuntu 22.04.
  - Instala las dependencias necesarias.
  - Clona el repositorio del módulo **nginx-rtmp-module**.
  - Descarga, compila e instala Nginx con soporte para RTMP y SSL.
  - Copia el archivo de configuración `nginx.conf` al contenedor.
- **nginx.conf:** 
  - Configura el servidor RTMP en el puerto 1935 para la aplicación `live`.
  - Habilita HLS, definiendo la ruta y parámetros de fragmentación.
  - Configura un servidor HTTP en el puerto 8080 para servir contenido web y archivos HLS.
- **html/index.html:** Página web que utiliza **hls.js** para reproducir la transmisión en vivo. Incluye un reproductor de video y algunos estilos básicos para mejorar la apariencia.

## Cómo Usar el Proyecto

1. **Clonar el repositorio:**
   ```bash
   git clone <URL-del-repositorio>
   cd <nombre-del-repositorio>
   ```
2. **Levantar el servicio con Docker Compose:**
   ```bash
   docker-compose up --build
3. **Acceder a la transmisión:**

   - RTMP: El servidor estará escuchando en rtmp://localhost:1935/live.
   - HLS y Página Web: Abre tu navegador y accede a http://localhost:8080 para ver la página con el reproductor de video.

## Notas

   - Asegúrate de que el puerto 1935 y 8080 no estén en uso por otros servicios en tu máquina.
   - La configuración de HLS en nginx.conf utiliza una ruta en el sistema de archivos del contenedor (/var/www/html/hls). Puedes personalizarla según tus necesidades.

## Contribuciones

Las contribuciones son bienvenidas. Si deseas mejorar este proyecto, siéntete libre de enviar un pull request o abrir un issue.

## Licencia

Este proyecto se distribuye bajo la licencia MIT.