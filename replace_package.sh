
mvn package

/home/ec2-user/apache-tomcat-8.5.32/bin/shutdown.sh

rm -rf /home/ec2-user/apache-tomcat-8.5.32/webapps/pfcase*

cp target/pfcase.war /home/ec2-user/apache-tomcat-8.5.32/webapps/

/home/ec2-user/apache-tomcat-8.5.32/bin/startup.sh



