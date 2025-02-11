CURR=./backups/current-tree

mkdir -p ${CURR}

rsync                                                   \
                                                        \
-av                                                     \
--delete                                                \
--exclude='data/ha/config/backups'                      \
--exclude='data/ha/config/home-assistant.log*'          \
--exclude='data/mqtt/log'                               \
--exclude='data/z2m/app/data/log'                       \
                                                        \
./data                                                  \
${CURR}

cp ./compose.yaml ${CURR}
cp ./.env ${CURR}

