#!/bin/bash

yum install ansible -y &>> /opt/userdata.log

ansible-pull -i localhost, -U https://github.com/hemanthtadikonda/poli.git chocolux.yml &>> /opt/userdata.log