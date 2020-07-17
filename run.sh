while [ "$(curl mysql:3306 &> /dev/null ; echo $?)" != "0" ]; do sleep 5; done
if [ $(echo 'show tables;' | mysql -h mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -D $MYSQL_DATABASE | grep -c RS_USER) -eq 0 ]; then
    sql=$(find . -name '*MySQL5_CREATE.sql')
    mysql -h mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -D $MYSQL_DATABASE < $sql
fi

cat > /app/apache-tomcat-8.5.38/webapps/reportserver/WEB-INF/classes/persistence.properties <<HERE
hibernate.connection.username=$MYSQL_USER
hibernate.connection.password=$MYSQL_PASSWORD
hibernate.dialect=net.datenwerke.rs.utils.hibernate.MySQL5Dialect
hibernate.connection.driver_class=com.mysql.jdbc.Driver
hibernate.connection.url=jdbc:mysql://mysql:3306/$MYSQL_DATABASE?useSSL=false
HERE

cd /app/apache-tomcat-8.5.38/bin
su -s /bin/bash tomcat -c './catalina.sh run'
