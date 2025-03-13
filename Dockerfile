# Dockerfile
FROM ubuntu:22.04

# Evitar interacciones durante la instalación
ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y \
    build-essential \
    libpcre3 libpcre3-dev \
    zlib1g zlib1g-dev \
    libssl-dev \
    git \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Establecer directorio de trabajo
WORKDIR /usr/local/src

# Clonar el módulo RTMP
RUN git clone https://github.com/arut/nginx-rtmp-module.git

# Descargar y descomprimir el código fuente de Nginx
RUN wget http://nginx.org/download/nginx-1.25.3.tar.gz && \
    tar -zxvf nginx-1.25.3.tar.gz

# Compilar Nginx con el módulo RTMP y soporte SSL
WORKDIR /usr/local/src/nginx-1.25.3
RUN ./configure --add-module=../nginx-rtmp-module --with-http_ssl_module && \
    make && \
    make install

# Crear el directorio de configuración si no existe
RUN mkdir -p /usr/local/nginx/conf/

# Copiar la configuración personalizada de Nginx (nginx.conf)
COPY nginx.conf /usr/local/nginx/conf/nginx.conf

# Exponer los puertos necesarios: 1935 (RTMP) y 8080 (HTTP para HLS)
EXPOSE 1935 8080

# Ejecutar Nginx en primer plano
CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]