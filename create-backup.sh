mkdir ./backups

tar                                                     \
                                                        \
--exclude='data/ha/config/backups'                      \
--exclude='data/ha/config/home-assistant.log*'          \
--exclude='data/mqtt/log'                               \
--exclude='data/z2m/app/data/log'                       \
                                                        \
-czvf                                                   \
                                                        \
./backups/ha-stack-data-$(date '+%F--%H-%M-%S').tar.gz  \
                                                        \
./data                                                  \
./compose.yaml                                          \
./.env
