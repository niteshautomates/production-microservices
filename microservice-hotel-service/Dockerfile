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

COPY --from=base app/target/HotelService-0.0.1-SNAPSHOT.jar target/HotelService-0.0.1-SNAPSHOT.jar
# Expose the port that the hotel service will run on
EXPOSE 8082

# Run the hotel service
CMD ["java", "-jar", "target/HotelService-0.0.1-SNAPSHOT.jar"]