make docker-reset
make docker-build
make docker-start

docker exec -it kafka-broker kafka-topics --bootstrap-server broker.kerberos.example:9092 --create --topic hztest --command-config /etc/kafka/kafka-client.properties

docker exec -it kafka-broker bash -c "cat /etc/passwd | kafka-console-producer --bootstrap-server broker.kerberos.example:9092 --topic hztest --producer.config /etc/kafka/kafka-client.properties"

docker exec -it kafka-broker kafka-console-consumer --bootstrap-server broker.kerberos.example:9092 --topic hztest --consumer.config /etc/kafka/kafka-client.properties --from-beginning 
