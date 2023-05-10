domain=$(cat /etc/xray/domain)
#cat >/root/cinta <<EOF
cat >/etc/nginx/conf.d/xray.conf <<EOF
   server {
             listen 8000;
             listen [::]:8000;
             root /var/www/html;
        }
    server
             listen 80;
             listen [::]:80;
             listen 2052;
             listen [::]:2052;
             listen 2082;
             listen [::]:2082;
             listen 2086;
             listen [::]:2086;
             listen 2095;
             listen [::]:2095;
             listen 8080;
             listen [::]:8080;
             listen 8880;
             listen [::]:8880;
             listen 443 ssl http2;
             listen [::]:443 ssl http2;
             listen 2053 ssl ssl http2;
             listen [::]:2053 ssl http2;
             listen 2083 ssl ssl http2;
             listen [::]:2083 ssl http2;
             listen 2087 ssl ssl http2;
             listen [::]:2087 ssl http2;
             listen 2096 ssl ssl http2;
             listen [::]:2096 ssl http2;
             listen 8443 ssl ssl http2;
             listen [::]:8443 ssl http2;
             ssl_certificate /usr/local/etc/xray/fullchain.crt;
             ssl_certificate_key /usr/local/etc/xray/private.key;
             ssl_ciphers EECDH+CHACHA20:EECDH+CHACHA20-draft:EECDH+ECDSA+AES128:EECDH+aRSA+AES128:RSA+AES128:EECDH+ECDSA+AES256:EECDH+aRSA+AES256:RS>
             ssl_protocols TLSv1.1 TLSv1.2 TLSv1.3;
location / {
if ($http_upgrade != "Upgrade") {
rewrite /(.*) /vmess break;
}
proxy_redirect off;
proxy_pass http://127.0.0.1:10001;
proxy_http_version 1.1;
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
proxy_set_header Upgrade $http_upgrade;
proxy_set_header Connection "upgrade";
proxy_set_header Host $host;
}
location /vless {
proxy_redirect off;
proxy_pass http://127.0.0.1:10002;
proxy_http_version 1.1;
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
proxy_set_header Upgrade $http_upgrade;
proxy_set_header Connection "upgrade";
proxy_set_header Host $host;
}
location /trojan {
proxy_redirect off;
proxy_pass http://127.0.0.1:10003;
proxy_http_version 1.1;
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
proxy_set_header Upgrade $http_upgrade;
proxy_set_header Connection "upgrade";
proxy_set_header Host $host;
}
location /shadowsocks {
proxy_redirect off;
proxy_pass http://127.0.0.1:10004;
proxy_http_version 1.1;
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
proxy_set_header Upgrade $http_upgrade;
proxy_set_header Connection "upgrade";
proxy_set_header Host $host;
}
location /shadowsocks2022 {
proxy_redirect off;
proxy_pass http://127.0.0.1:10005;
proxy_http_version 1.1;
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
proxy_set_header Upgrade $http_upgrade;
proxy_set_header Connection "upgrade";
proxy_set_header Host $host;
}
location /socks5 {
proxy_redirect off;
proxy_pass http://127.0.0.1:10006;
proxy_http_version 1.1;
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
proxy_set_header Upgrade $http_upgrade;
proxy_set_header Connection "upgrade";
proxy_set_header Host $host;
}
location ^~ /vmess-grpc {
proxy_redirect off;
grpc_set_header X-Real-IP $remote_addr;
grpc_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
grpc_set_header Host $http_host;
grpc_pass grpc://127.0.0.1:20001;
}
location ^~ /vless-grpc {
proxy_redirect off;
grpc_set_header X-Real-IP $remote_addr;
grpc_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
grpc_set_header Host $http_host;
grpc_pass grpc://127.0.0.1:20002;
}
location ^~ /trojan-grpc {
proxy_redirect off;
grpc_set_header X-Real-IP $remote_addr;
grpc_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
grpc_set_header Host $http_host;
grpc_pass grpc://127.0.0.1:20003;
}
location ^~ /shadowsocks-grpc {
proxy_redirect off;
grpc_set_header X-Real-IP $remote_addr;
grpc_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
grpc_set_header Host $http_host;
grpc_pass grpc://127.0.0.1:20004;
}
location ^~ /shadowsocks2022-grpc {
proxy_redirect off;
grpc_set_header X-Real-IP $remote_addr;
grpc_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
grpc_set_header Host $http_host;
grpc_pass grpc://127.0.0.1:20005;
}
location ^~ /socks5-grpc {
proxy_redirect off;
grpc_set_header X-Real-IP $remote_addr;
grpc_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
grpc_set_header Host $http_host;
grpc_pass grpc://127.0.0.1:20006;
}
        }
EOF
