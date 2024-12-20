docker-build:
	docker compose build

docker-start:
	docker compose up -d kerberos
	sleep 3
	docker compose up -d

docker-test:
	# docker exec -t kafka-client kinit -kt /etc/security/keytabs/kafka-producer.keytab kafka-producer/kafkaclient@UNEY.COM
	docker exec -it kafka-client python3 ingest-test-kafka-data.py

docker-reset:
	docker compose stop
	rm -rf kerberos/keytabs
	rm -rf kerberos/krb5kdc
	docker system prune -f