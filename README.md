Sonrqube is an open-source, java based code review tool which does:

1. Bug tracking

2. Vulnerability checks

3. Indentify code smells

4. Code coverage

5. Identify Duplicate code

It runs on the port 9000 by default

4 GB RAM is recommended to run this so choose relevant EC2 instance

## Insallation on EC2 instance
```
sudo apt update
sudo su
cd /opt
sudo apt install default-jre
java -version
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-25.5.0.107428.zip
mv sonarqube-25.5.0.107428.zip sonarqube.zip
unzip sonarqube.zip
```

It is worth noting that SonarQube server will not run with root user
```
useradd sonar
visudo
```
Configure sonar user without pwd in the suderos file by adding `sonar ALL=(ALL) NOPASSWD: ALL`

Change ownership for sonar folder/directory:
```
chown -R sonar:sonar /opt/sonarqube/
chmod -R 775 /opt/sonarqube
su sonar
```
Goto bin/linux directory, run sonar server:
```
cd /opt/sonarqube/bin/linux-x86-64
sh sonar.sh start
```
Check sonar server status 
```
sh sonar.sh status
```
The default port of sonar serve can be changed at ( conf/sonar.properties) like `sonar.web.port=6000`
