BACKUP_TIMESTAMP=$(./ha-date.sh)
TGZ_NAME=ha-stack-data-${BACKUP_TIMESTAMP}.tar.gz

cd ./backups/current-tree

echo start creating ${TGZ_NAME}

tar            \
               \
-czf           \
               \
../${TGZ_NAME} \
               \
./data         \
./compose.yaml \
./.env

echo finish creating ${TGZ_NAME}
