# Stage 1: Build
FROM maven:3.9.0-eclipse-temurin-17 AS build

WORKDIR /app

# Copy pom.xml for caching dependencies
COPY pom.xml .

# Download dependencies
RUN mvn dependency:go-offline

# Copy source code
COPY src ./src

# Build project
RUN mvn clean package -DskipTests

# Stage 2: Run
FROM eclipse-temurin:17-jre

WORKDIR /app

# Copy the built jar
COPY --from=build /app/target/*.jar app.jar

# Expose port for app
EXPOSE 8080

# Run the jar
ENTRYPOINT ["java", "-jar", "app.jar"]
