#!/bin/bash
set -eux

dnf install -y nginx

cat > /usr/share/nginx/html/index.html <<'EOF'
<!DOCTYPE html>
<html>
<head>
  <title>Auto-Healing Web Tier</title>
</head>
<body>
  <h1>Auto-Healing Web Tier</h1>
  <p>NGINX is running.</p>
</body>
</html>
EOF

systemctl enable nginx
systemctl start nginx