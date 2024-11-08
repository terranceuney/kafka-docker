docker-start:
	docker compose up -d

docker-reset:
	docker compose stop
	rm -rf kerberos/keytabs
	docker system prune -f