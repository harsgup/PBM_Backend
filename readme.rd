//to run docker of msql

docker run -d \
  --name my-mysql \
  -e MYSQL_ROOT_PASSWORD=rootpassword \
  -e MYSQL_DATABASE=fastapidb \
  -p 3306:3306 \
  mysql:8.0


//to dump data in SQLTool

docker exec -i my-mysql mysql -u root -prootpassword fastapidb < dump.sql #this will copy the file first
docker exec -it my-mysql mysql -u root -prootpassword fastapidb -e "source /tmp/dump.sql"
