# Use an official Maven image as a build environment
FROM maven:3.8.4-openjdk-11 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the project files into the container
COPY . .

# Build the application
RUN mvn clean package

# Use a lightweight OpenJDK runtime as the final base image
FROM openjdk:11-jre-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file from the build image into the final image
COPY --from=build /app/target/config-server-0.0.1-SNAPSHOT.jar /app/

# Specify the command to run on container start
CMD ["java", "-jar", "config-server-0.0.1-SNAPSHOT.jar"]