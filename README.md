# Process Automation with ASP.NET Core Microservices
* Jenkins is running in a container and sending instructions to the docker host trough the mapped volume /var/run/docker.sock
- To build and start the Jenkins pipeline, run:
1. docker-compose -f ./Jenkins/Docker-compose.yml build
2. docker-compose -f /Jenkins/Docker-compose.yml up -d
3. "Jenkins/run after jenkins start.ps1"  <-or->  docker exec -it -u root jenkins bash -c 'chmod 777 /var/run/docker.sock'

- Once Jenkins container is runnig we can logon: http://localhost:8180/ and create a new pipeline.

- The docker-compose network is extending the network that is created in /Jenkins/docker-compose.yml
- For that reason we should first run /Jenkins/docker-compose.yml and after that /docker-compose.yml
- After the Jenkins container is running we can run a build or manually build and start the whole project:
4. docker-compose build
5. docker-compose up -d
