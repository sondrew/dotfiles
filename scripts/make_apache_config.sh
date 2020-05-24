#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]
  then echo "Please run script as root"
  exit 1
fi

if [ $# -eq 0 ]
    then
    echo "Provide at least one argument (e.g. 'example.com')"
    exit 1
fi


for var in "$@"
do

# Create config for each argument
echo "Creating Apache2 config for $var"

# Create directory for our public html files
sudo mkdir -p /var/www/$var/public_html
# Add user as owner of directory
sudo chown -R $USER:$USER /var/www/$var/public_html
# Set permission: full permissions for owner and read/execute permission for others
sudo chmod -R 755 /var/www

echo "Creating demo page for domain at /var/www/$var/public_html/index.html"
cat > /var/www/$var/public_html/index.html << EOF
<html>
  <head>
    <title>Welcome to $var!</title>
  </head>
  <body>
    <h1>Success! The $var virtual host is working!</h1>
  </body>
</html>
EOF

echo "Creating apache virtual host config at /etc/apache2/sites-available/$var.conf"
sudo cat > /etc/apache2/sites-available/$var.conf << EOF
<VirtualHost *:80>
    ServerAdmin admin@$var
    ServerName $var
    ServerAlias www.$var
    DocumentRoot /var/www/$var/public_html
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

# Enable apache config - no need to specify directory or .conf suffix
sudo a2ensite $var
echo "Apache config enabled for $var"

done

echo "Restarting Apache server..."
# Restart apache for config to take effect
sudo systemctl restart apache2

echo "Apache configuration complete"
exit 0
