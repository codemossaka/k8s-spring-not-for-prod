# Use an OpenJDK base image
FROM openjdk:17-alpine

# Set the working directory in the container
WORKDIR /app

# Install curl and bash (bash is needed because your CMD uses bash)
RUN apk update && apk add curl bash

# Copy the Maven wrapper and the pom.xml file first to leverage Docker caching
COPY ./mvnw ./mvnw
COPY ./pom.xml ./pom.xml
COPY ./.mvn ./.mvn

# Build Maven dependencies in a separate Docker layer to leverage caching
RUN ./mvnw dependency:go-offline -B

# Now copy the rest of the project files
COPY . .

# Build the Maven project and skip tests (you can remove -DskipTests if you want to run tests)
RUN ./mvnw clean package -DskipTests

# Expose the port your application runs on
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "target/simple-rest-api-1.0.0.jar"]
