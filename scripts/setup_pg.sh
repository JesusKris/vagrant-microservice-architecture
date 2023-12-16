#!/bin/bash

USERNAME=$1
PASSWORD=$2
DB_NAME=$3


# System updates
sudo apt update
sudo apt upgrade

# Install postgresql
sudo apt install -y postgresql postgresql-contrib

# Create a PostgreSQL user
sudo -u postgres psql -c "CREATE USER $USERNAME WITH PASSWORD '$PASSWORD';"

# Create a PostgreSQL database
sudo -u postgres psql -c "CREATE DATABASE $DB_NAME OWNER $USERNAME;"

# Restart PostgreSQL to apply changes
sudo service postgresql restart