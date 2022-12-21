# nwomib_infra
nwomib Infra repository

ssh -i ~/.ssh/appuser -A -t appuser@51.250.13.255 ssh appuser@10.128.0.3

Добавим запись в хостс запись 10.128.0.3 someinternalhost

ssh -i ~/.ssh/appuser -A -t appuser@51.250.13.255 ssh appuser@someinternalhost

bastion_IP = 51.250.13.255
someinternalhost_IP = 10.128.0.3