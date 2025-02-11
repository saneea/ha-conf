cd ./backups/current-tree

tar                                                     \
                                                        \
-czf                                                    \
                                                        \
../ha-stack-data-$(date '+%F--%H-%M-%S').tar.gz         \
                                                        \
./data                                                  \
./compose.yaml                                          \
./.env

