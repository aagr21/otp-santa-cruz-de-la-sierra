# Usa una imagen base con OpenTripPlanner y Java 21
FROM openjdk:21-jdk-slim

# Establece el directorio de trabajo
WORKDIR /var/opentripplanner

# Copia los archivos locales al contenedor
COPY data/santa-cruz-de-la-sierra.pbf /var/opentripplanner/
COPY data/graph.obj /var/opentripplanner/

# Instala curl si no está presente
RUN apt-get update && \
    apt-get install -y curl && \
    apt-get clean

# Descarga el archivo JAR de OpenTripPlanner
RUN curl -L https://github.com/opentripplanner/OpenTripPlanner/releases/download/v2.5.0/otp-2.5.0-shaded.jar -o opentripplanner.jar

# Expone el puerto para servir el gráfico
EXPOSE 8080

# Establece el comando por defecto para construir y servir el gráfico
CMD ["java", "-Xmx150M", "-jar", "opentripplanner.jar", "--load", "--serve", "/var/opentripplanner"]