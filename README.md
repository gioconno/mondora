# mondora
Repo per test docker

Procedimento:
> installato e testato docker-ce seguendo le istruzioni https://docs.docker.com/install/linux/docker-ce/ubuntu/
>> non sono riuscito a configuare gli step post installazione (https://docs.docker.com/install/linux/linux-postinstall/), per aggirare il problema ho creato il file .bash_aliases aggiungendo l'alias docker='sudo docker'
> Scaricata l'immagine maven ($ docker pull maven)
> Clonata la repository https://github.com/davidkiss/yourl.git nella directory ~/<MANCA PEZZO>
> Installato maven sulla macchina locale per testare la build
> Modificato il file pom.xml aggiungendo la seguente dipendenza, causa Java 11 (jaxb deprecato)
    <dependency>
      <groupId>javax.xml.bind</groupId>
      <artifactId>jaxb-api</artifactId>
      <version>2.3.0</version>
    </dependency>
> Creato dockerfile (allegato nella repository): partendo dall'immagine maven, vengono copiati nella cartella root (/) il file pom.xml e la cartella /src. Viene esposta la porta 8080 del container.
> Creata l'immagine 'yourl' con i file sopra elencanti: $ docker build -t yourl .
> Eseguito il comando 'mvn spring-boot:run' nel container con nome 'zanchi' (--name), in background (-d) e mappando la porta 8080 del container alla porta 8080 del sistema ospite (-p 8080:8080) :: $ docker run -d -p 8080:8080 --name zanchi yourl mvn spring-boot:run
> Installato nginx sul sistema ospite
> Modificato il file di nginx in modo da reindirzzare lo URL pr-zanchi.mondora.com/yourl verso la porta 8080 del sistema (e quindi al servizio esposto)

