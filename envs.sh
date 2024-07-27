#!/bin/bash

# File to save the environment variables
ENV_FILE=".env"

# List of environment variable keys
# You can add or remove keys as per your requirement
ENV_KEYS=(
  "TINYAPI"
  "STORAGEBUCKET"
  "MONGO_URL"
)

# Check if the .env file exists and back it up if it does
if [ -f "$ENV_FILE" ]; then
  cp "$ENV_FILE" "${ENV_FILE}.bak"
fi

# Clear the .env file
> "$ENV_FILE"

# Iterate through the list of keys and save each key-value pair to the .env file
for key in "${ENV_KEYS[@]}"; do
  value=$(printenv "$key")
  if [ -n "$value" ]; then
    echo "$key=$value" >> "$ENV_FILE"
  else
    echo "Warning: $key is not set"
  fi
done

echo "Environment variables saved to $ENV_FILE."
