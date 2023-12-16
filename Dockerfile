FROM eclipse-temurin:20-jdk AS build
COPY . /app
WORKDIR /app
RUN ./gradlew bootJar
RUN mv -f build/libs/*.jar app.jar

FROM eclipse-temurin:20-jre
ARG PORT
ENV PORT=${PORT}
COPY --from=build /app/app.jar .
COPY waitlistapp/waitlist-app-0.6.2.jar
RUN useradd runtime
USER runtime
ENTRYPOINT [ "java", "-Dserver.port=${PORT}", "-jar", "app.jar" ]
