# Pull a lightweight version of Ubuntu
FROM maven:3.8.3-openjdk-17 AS base

# Set the working directory in the container
WORKDIR /app

# Copy the user service project files into the container
COPY pom.xml .

COPY src ./src
# Build the project using Maven
RUN mvn clean package -Dmaven.test.skip=true

# Expose the port that the user service will run on
EXPOSE 8081

# Run the user service
CMD ["java", "-jar", "target/UserService-0.0.1-SNAPSHOT.jar"]