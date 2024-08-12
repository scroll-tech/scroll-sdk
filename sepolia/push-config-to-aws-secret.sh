#!/bin/bash

# Check if region parameter was provided
if [ $# -eq 0 ]; then
  echo "Usage: $0 us-east-1"
  echo "Please provide the aws region."
  exit 1
fi

region=$1

# Function to convert env files to json
convert_to_json() {
  local file="$1"
  local json_content="{"
  while IFS= read -r line; do
    if [[ -n "$line" ]]; then
      key=$(echo "$line" | cut -d':' -f1 | xargs)
      value=$(echo "$line" | cut -d':' -f2- | xargs | sed 's/^"//' | sed 's/"$//')
      json_content+="\"$key\":\"$value\","
    fi
  done < "$file"
  json_content="${json_content%,}}"
  echo "$json_content"
}

# Function to push file content to AWS Secrets Manager
push_to_aws_secret() {
  local file_content="$1"
  local secret_name="$2"

  # Push the content to AWS Secrets Manager
  aws secretsmanager create-secret --name "scroll-sepolia/$secret_name" --secret-string "$file_content" --region $region > /dev/null 2>&1

  # Check if the command was successful
  if [[ $? -eq 0 ]]; then
    echo "Successfully pushed content of $file_path to AWS Secret $secret_name."
  else
    echo "Failed to push content of $file_path to AWS Secret $secret_name."
  fi
}

# List all .json files in the current directory
json_files=$(ls *.json 2> /dev/null)


# Check if there are any .json files
if [[ -z "$json_files" ]]; then
  echo "No .json files found in the current directory."
  exit 1
fi

# Iterate over each JSON file and push its content to AWS Secrets Manager
for file in $json_files; do
  # Extract the base name of the file without the extension to use as the secret name
  secret_name=$(basename "$file" .json)
  # Read the content of the file
  file_content=$(cat "$file")
  # Call the function to push the content to AWS Secrets Manager
  push_to_aws_secret "$file_content" "$secret_name"
done

# List all .env files in the current directory
env_files=$(ls secrets/*.env 2> /dev/null)

# Iterate over each ENV file and push its content to AWS Secrets Manager
for file in $env_files; do
  # Transform .env files into a json
  json_file=$(convert_to_json $file)
  # Extract the base name of the file without the extension to use as the secret name
  secret_name=$(basename "$file" .env)
  secret_name="$secret_name-env"

  # Call the function to push the content to AWS Secrets Manager
  push_to_aws_secret "$json_file" "$secret_name"
done
