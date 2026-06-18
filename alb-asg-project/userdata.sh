#!/bin/bash

# Update system
sudo apt update -y

# Install nginx
sudo apt install -y nginx

# Start and enable nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Get metadata (more reliable than hostname -I)
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
HOSTNAME=$(hostname)

# Create HTML page
cat <<EOF | sudo tee /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>Server Details</title>
</head>
<body>
    <h1>Server Details</h1>
    <p><strong>Hostname:</strong> $HOSTNAME</p>
    <p><strong>Instance ID:</strong> $INSTANCE_ID</p>
    <p><strong>Public IP:</strong> $PUBLIC_IP</p>
</body>
</html>
EOF

# Restart nginx
sudo systemctl restart nginx
