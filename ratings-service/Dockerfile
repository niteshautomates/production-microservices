FROM maven:3.8.3-openjdk-17 AS base

# Set the working directory in the container
WORKDIR /app

# Copy the user service project files into the container
COPY pom.xml .

COPY src ./src
# Build the project using Maven
RUN mvn clean package -Dmaven.test.skip=true


FROM maven:3.8.3-openjdk-17 AS runtime

WORKDIR /app
# Expose the port that the ratings service will run on
EXPOSE 8083

COPY --from=base app/target/Rating-0.0.1-SNAPSHOT.jar target/Rating-0.0.1-SNAPSHOT.jar
# Run the ratings service
CMD ["java", "-jar", "target/Rating-0.0.1-SNAPSHOT.jar"]