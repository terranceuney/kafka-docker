docker compose stop
docker system prune -f 
rm -rf ./kerberos/keytabs
rm -rf ./kerberos/krb5kdc

docker compose up -d kerberos
sleep 3
docker compose up -d

echo "[LOCAL] test on local kafka & verify success!!!"
docker exec -t kafka kafka-topics --bootstrap-server kafka:9092 --create --topic hztest --command-config /etc/kafka/kafka-client.properties

docker exec -t kafka bash -c "cat /etc/passwd | kafka-console-producer --bootstrap-server kafka:9092 --topic hztest --producer.config /etc/kafka/kafka-client.properties"

docker exec -t kafka kafka-console-consumer --bootstrap-server kafka:9092 --topic hztest --consumer.config /etc/kafka/kafka-client.properties --from-beginning --max-messages 10

echo "[WARNING!!!] please copy kafka-producer.keytab into ./kerberos/keytabs/ then run below commands"
exit 0 

echo "[LOCAL] test on h100 kafka"
cp /etc/krb5-h100.conf /etc/krb5.conf
docker exec -it kafka env KRB5_CONFIG=/etc/krb5-h100.conf KAFKA_OPTS='-Djava.security.auth.login.config=/etc/kafka/kafka_client_jaas.conf -Djava.security.krb5.conf=/etc/krb5-h100.conf -Dsun.security.krb5.debug=true'  kafka-topics --bootstrap-server kafka.h100-smartai.com:54092 --create --topic hztest --command-config /etc/kafka/kafka-h10-client.properties