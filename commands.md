### Connect to docker container

docker container exec -it {name/id} /bin/bash

### Cron using systemd

(Active systemctl on system boot)
systemctl enable nextcloudcron.timer

(Start nextcloud cron at once!)
systemctl start nextcloudcron.timer

(Check the status of nextcloud cron service)
systemctl status nextcloudcron.timer