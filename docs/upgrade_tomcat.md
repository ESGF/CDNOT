### prepare new version
```
cd /usr/local 
wget https://dlcdn.apache.org/tomcat/tomcat-8/v8.5.82/bin/apache-tomcat-8.5.82.tar.gz (or most recent version)
tar xzf apache-tomcat-8.5.82.tar.gz 
chown -R tomcat:tomcat apache-tomcat-8.5.82
cp -a /usr/local/tomcat/conf/context.xml /usr/local/apache-tomcat-8.5.82/conf/
cp -a /usr/local/tomcat/conf/server.xml /usr/local/apache-tomcat-8.5.82/conf/
cp -a /usr/local/tomcat/bin/setenv.sh /usr/local/apache-tomcat-8.5.82/bin
cp -a /usr/local/tomcat/webapps/* /usr/local/apache-tomcat-8.5.82/webapps/
```
### hide tomcat version for more security
```
mkdir -p /usr/local/apache-tomcat-8.5.82/lib/org/apache/catalina/util
echo server.info=Apache Tomcat > /usr/local/apache-tomcat-8.5.82/lib/org/apache/catalina/util/ServerInfo.properties   
```
### update server.xml
```
vim  /usr/local/apache-tomcat-8.5.82/conf/server.xml (add "secretRequired" ~l.105)
			   maxConnections="256" keepAliveTimeout="30000" secretRequired="false" />
```
### finally move to new version
```
ansible-playbook -v -i hosts.prod stop.yml 
cd /usr/local 
ln -sfn apache-tomcat-8.5.82 tomcat
ansible-playbook -v -i hosts.prod start.yml
```
