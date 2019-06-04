FROM maven

COPY pom.xml /
COPY src /src 

EXPOSE 8080
