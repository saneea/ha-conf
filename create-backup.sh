tar							\
--exclude='data/ha/config/backups'			\
--exclude='data/ha/config/home-assistant.log*'		\
--exclude='data/mqtt/log'				\
--exclude='data/z2m/app/data/log'			\
-czvf							\
my-back.tar.gz						\
./data
