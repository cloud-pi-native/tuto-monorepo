#!/bin/sh

ROOT_DIR=/opt/bitnami/nginx/html

populate () {
  KEY=$(echo "app-$1" | tr '[:upper:]' '[:lower:]' | sed 's/_/-/g')
  VALUE=$(eval "echo \${$1}")
  sed -i 's|'${KEY}'|'${VALUE}'|g' $2
}


echo "Replacing env constants in JS"
for file in $ROOT_DIR/assets/*.js; do
  echo "Processing $file ...";

  populate VITE_SERVER_HOST $file
done

nginx -g 'daemon off;'
