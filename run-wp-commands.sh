#!/bin/bash

# Install jq for JSON parsing
apk add --no-cache jq

# Wait until the database connection is ready
until wp db check --allow-root; do
  echo 'Waiting for WordPress database connection...'
  sleep 5
done

# Ensure the correct ownership and permissions on wp-content directories
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html
chown -R www-data:www-data /var/www/html/wp-content
chmod -R 755 /var/www/html/wp-content

# Process WP-CLI commands from the JSON file
jq -c '.[]' /wp-cli-commands.json | while read -r cmd; do
  command=$(echo "$cmd" | jq -r ".command")

 args=$(echo "$cmd" | jq -r '
    .args | 
    to_entries | 
    map(
      if .key == "slug" then 
        .value 
      else 
        "--" + .key + 
        (if .value == true then 
          "" 
        else 
          "=" + "\"" + (.value | tostring) + "\"" 
        end) 
      end
    ) | 
    join(" ")
  ')

  full_command="wp $command $args --allow-root"

  echo "Running: $full_command"

  eval $full_command

  #Set permissions on uploads and upgrade directories
  if [ -d /var/www/html/wp-content/uploads ]; then
    chown -R www-data:www-data /var/www/html/wp-content/uploads
    chmod -R 775 /var/www/html/wp-content/uploads
  fi
  if [ -d /var/www/html/wp-content/upgrade ]; then
    chown -R www-data:www-data /var/www/html/wp-content/upgrade
    chmod -R 775 /var/www/html/wp-content/upgrade
  fi
done

echo -e 'Connect at \033[32mhttp://localhost/wp-admin\033[0m'

# Keep the service running
tail -f /dev/null
