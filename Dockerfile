FROM openjdk:16-jdk-alpine

# Create a new user and group for running the application
RUN addgroup -S spring && adduser -S spring -G spring

# Expose port 8080
EXPOSE 8080

# Set environment variable for Spring profile
ENV JAVA_PROFILE=prod

# Define the build argument for dependencies
ARG DEPENDENCY=target/dependency

# Copy dependencies, metadata, and class files into the container
COPY ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY ${DEPENDENCY}/META-INF /app/META-INF
COPY ${DEPENDENCY}/BOOT-INF/classes /app

# Set the entrypoint to run the Spring Boot application
ENTRYPOINT ["java", \
  "-Dspring.profiles.active=${JAVA_PROFILE}", \
  "-cp", "app:app/lib/*", "camt.se234.lab10.Lab10Application"]
