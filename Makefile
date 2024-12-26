up:
	docker compose up -d

down:
	docker compose down

logs:
	docker compose logs

create_mosquitto_conf:
	touch ./data/mosquitto/config/mosquitto.conf

