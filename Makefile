DC=docker compose --progress plain

up:
	$(DC) up -d

down:
	$(DC) down

logs:
	$(DC) logs

cold-backup:
	$(DC) pause
	-./sync-work-tree.sh
	$(DC) unpause
	./backup-work-tree.sh
