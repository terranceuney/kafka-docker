docker-build:
	docker compose build

docker-start:
	docker compose up -d

docker-test:
	# docker exec -t kafka-client kinit -kt /etc/security/keytabs/jduke.keytab jduke@KERBEROS.EXAMPLE
	docker exec -it kafka-client python3 ingest-test-kafka-data.py

docker-reset:
	docker compose stop
	rm -rf kerberos/keytabs
	docker system prune -f