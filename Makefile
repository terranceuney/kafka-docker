docker-build:
	docker compose build

docker-start:
	docker compose up -d kerberos
	sleep 3
	docker compose up -d

docker-test:
	docker exec -it kafka bash -c "cat /etc/passwd | kafka-console-producer --bootstrap-server kafka:9092 --topic hztest --producer.config /etc/kafka/kafka-client.properties"
	docker exec -it kafka kafka-console-consumer --bootstrap-server kafka:9092 --topic hztest --consumer.config /etc/kafka/kafka-client.properties --from-beginning --max-messages 5

docker-reset:
	docker compose stop
	rm -rf kerberos/keytabs
	rm -rf kerberos/krb5kdc
	docker system prune -f