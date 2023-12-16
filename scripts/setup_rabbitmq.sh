#!/bin/sh

RABBITMQ_IP_ADDRESS=$1
RABBITMQ_PORT=$2
RABBITMQ_USER=$3
RABBITMQ_USER_PASSWORD=$4


sudo apt-get install curl gnupg apt-transport-https -y

## Team RabbitMQ's main signing key
sudo curl -1sLf "https://keys.openpgp.org/vks/v1/by-fingerprint/0A9AF2115F4687BD29803A206B73A36E6026DFCA" | sudo gpg --dearmor | sudo tee /usr/share/keyrings/com.rabbitmq.team.gpg > /dev/null
## Community mirror of Cloudsmith: modern Erlang repository
sudo curl -1sLf https://ppa1.novemberain.com/gpg.E495BB49CC4BBE5B.key | sudo gpg --dearmor | sudo tee /usr/share/keyrings/rabbitmq.E495BB49CC4BBE5B.gpg > /dev/null
## Community mirror of Cloudsmith: RabbitMQ repository
sudo curl -1sLf https://ppa1.novemberain.com/gpg.9F4587F226208342.key | sudo gpg --dearmor | sudo tee /usr/share/keyrings/rabbitmq.9F4587F226208342.gpg > /dev/null

## Add apt repositories maintained by Team RabbitMQ
sudo tee /etc/apt/sources.list.d/rabbitmq.list <<EOF
## Provides modern Erlang/OTP releases
##
deb [signed-by=/usr/share/keyrings/rabbitmq.E495BB49CC4BBE5B.gpg] https://ppa1.novemberain.com/rabbitmq/rabbitmq-erlang/deb/ubuntu bionic main
deb-src [signed-by=/usr/share/keyrings/rabbitmq.E495BB49CC4BBE5B.gpg] https://ppa1.novemberain.com/rabbitmq/rabbitmq-erlang/deb/ubuntu bionic main

## Provides RabbitMQ
##
deb [signed-by=/usr/share/keyrings/rabbitmq.9F4587F226208342.gpg] https://ppa1.novemberain.com/rabbitmq/rabbitmq-server/deb/ubuntu bionic main
deb-src [signed-by=/usr/share/keyrings/rabbitmq.9F4587F226208342.gpg] https://ppa1.novemberain.com/rabbitmq/rabbitmq-server/deb/ubuntu bionic main
EOF

## Update package indices
sudo apt-get update -y

## Install Erlang packages
sudo apt-get install -y erlang-base \
                        erlang-asn1 erlang-crypto erlang-eldap erlang-ftp erlang-inets \
                        erlang-mnesia erlang-os-mon erlang-parsetools erlang-public-key \
                        erlang-runtime-tools erlang-snmp erlang-ssl \
                        erlang-syntax-tools erlang-tftp erlang-tools erlang-xmerl

## Install rabbitmq-server and its dependencies
sudo apt-get install rabbitmq-server -y --fix-missing

# Manually edit rabbitmq-env.conf and change IP address and port
sudo sed -i 's/^#NODE_IP_ADDRESS=127.0.0.1/NODE_IP_ADDRESS='"$RABBITMQ_IP_ADDRESS"'/g' /etc/rabbitmq/rabbitmq-env.conf
sudo sed -i 's/^#NODE_PORT=5672/NODE_PORT='"$RABBITMQ_PORT"'/g' /etc/rabbitmq/rabbitmq-env.conf

# Create a new user and allow virtual host connections
sudo rabbitmqctl add_user "$RABBITMQ_USER" "$RABBITMQ_USER_PASSWORD"
sudo rabbitmqctl set_user_tags "$RABBITMQ_USER" administrator
sudo rabbitmqctl set_permissions -p / "$RABBITMQ_USER" ".*" ".*" ".*"

# Start the RabbitMQ service
sudo systemctl start rabbitmq-server

# Enable RabbitMQ service to start on boot
sudo systemctl enable rabbitmq-server

# Restart to apply changes
sudo systemctl restart rabbitmq-server

pm2 resurrect

pm2 restart 0