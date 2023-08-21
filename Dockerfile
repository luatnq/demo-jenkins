# Stage 1: Build the application
FROM maven AS build-dependency

ARG WORKDIR=/opt/app

WORKDIR ${WORKDIR}
COPY pom.xml .
RUN mvn dependency:go-offline

COPY src ./src
RUN mvn clean package -DskipTests


# Stage 2: Extract file jar for application image
FROM eclipse-temurin:17-jre-alpine as builder
ARG WORKDIR=/opt/app
ARG JAR_FILE=${WORKDIR}/target/*.jar

WORKDIR ${WORKDIR}
COPY  --from=build-dependency ${JAR_FILE} application.jar

RUN java -Djarmode=layertools -jar application.jar extract

# Stage 3: Create the final image
FROM eclipse-temurin:17-jre-alpine
ARG WORKDIR=/opt/app
WORKDIR ${WORKDIR}

COPY --from=builder ${WORKDIR}/dependencies/ ./
COPY --from=builder ${WORKDIR}/spring-boot-loader/ ./
COPY --from=builder ${WORKDIR}/snapshot-dependencies/ ./
COPY --from=builder ${WORKDIR}/application/ ./
ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]


