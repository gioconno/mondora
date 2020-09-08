# Mondora technical test
This was the final work shared for a job interview.

## Procedimento:
1. Installato e testato docker-ce seguendo le relative [istruzioni](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
   - Non sono riuscito a configuare gli step [post installazione](https://docs.docker.com/install/linux/linux-postinstall/), per aggirare il problema ho creato il file *.bash_aliases* aggiungendo l'alias `docker='sudo docker'`
2. Scaricata l'immagine maven (`$ docker pull maven`)
3. Clonata la repository https://github.com/davidkiss/yourl.git nella directory *~/yourl*
4. Installato maven sulla macchina locale per testare la build
5. Modificato il file pom.xml aggiungendo la seguente dipendenza, causa Java 11 (jaxb deprecato)
    ```
    <dependency>
      <groupId>javax.xml.bind</groupId>
      <artifactId>jaxb-api</artifactId>
      <version>2.3.0</version>
    </dependency>
    ```
6. Creato dockerfile (allegato nella repository)
```
# Immagine di partenza
FROM maven

# Copio le risorse necessarie alla build nella cartella root
COPY pom.xml /
COPY src /src

# Espongo la porta 8080 del container
EXPOSE 8080
```
7. Creata l'immagine *yourl* con i file sopra elencanti: `$ docker build -t yourl .`
8. Eseguito il comando `mvn spring-boot:run` nel container con nome *zanchi* (`--name zanchi`), in background (`-d`) e mappando la porta 8080 del container alla porta 8080 del sistema ospite (`-p 8080:8080`)
   - `$ docker run -d -p 8080:8080 --name zanchi yourl mvn spring-boot:run`
9. Installato nginx sul sistema ospite
10. Modificato il file */etc/nginx/sites-available/default* in modo da reindirzzare lo URL [pr-zanchi.mondora.com/yourl](http://pr-zanchi.mondora.com/yourl) verso la porta 8080 del sistema (e quindi al servizio esposto)
```
location /yourl {
    proxy_pass 127.0.0.1:8080/
}

```
11. ~~HTTPS: TBD~~
