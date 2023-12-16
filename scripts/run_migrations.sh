#!/bin/bash

FOLDER_PATH=$1


# Navigate to project root
cd "$FOLDER_PATH"

# Install sequelize-cli
npm install -g sequelize-cli

# Install npm runner npx
npm install -g npx

# Apply migrations using the CLI
npx sequelize-cli db:migrate --config config/config.js
