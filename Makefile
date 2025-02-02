DC=docker compose --progress plain

up:
	$(DC) up -d

down:
	$(DC) down

logs:
	$(DC) logs

cold-backup:
	$(DC) pause
	-./create-backup.sh
	$(DC) unpause
