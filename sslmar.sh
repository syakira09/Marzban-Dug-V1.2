mkdir /etc/xray
apt install socat -y
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}               • INPUT DOMAIN •                 ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
read -rp "Input ur domain : " -e pp
    echo "$pp" > /etc/xray/domain 
echo "Silahkan pilih menu Gen-Cert untuk mendapatkan cert domain baru"
echo "Press any key to back on menu"
clear
domain=$(cat /etc/xray/domain)
Cek=$(lsof -i:80 | cut -d' ' -f1 | awk 'NR==2 {print $1}')
if [[ ! -z "$Cek" ]]; then
sleep 1
echo -e "[ ${red}WARNING${NC} ] Detected port 80 used by $Cek " 
systemctl stop $Cek
sleep 2
echo -e "[ ${GREEN}INFO${NC} ] Processing to stop $Cek " 
sleep 1
fi
echo -e "[ ${GREEN}INFO${NC} ] Starting renew gen-ssl... "
sleep 2
yum install curl socat -y
curl https://get.acme.sh | sh
~/.acme.sh/acme.sh --set-default-ca --server letsencrypt
~/.acme.sh/acme.sh --register-account -m resaananta42@gmail.com
~/.acme.sh/acme.sh --issue -d $domain --standalone
~/.acme.sh/acme.sh --installcert -d $domain --key-file /etc/xray/xray.key --fullchain-file /etc/xray/xray.crt

echo -e "[ ${GREEN}INFO${NC} ] Renew gen-ssl done... " 
sleep 2
echo -e "[ ${GREEN}INFO${NC} ] Starting service $Cek " 
sleep 2
echo -e "[ ${GREEN}INFO${NC} ] All finished... " 
sleep 0.5
sudo apt install nginx -y
cd
curl -fsSL https://get.docker.com | sh
#wget -q -O /etc/nginx/conf.d/xray.conf "https://raw.githubusercontent.com/syakira09/MarXray-Dug-V1.1/master/xray.conf"
#sed -i 's/kiko8.pisces.my.id/${domain}/g' /etc/nginx/conf.d/xray.conf
wget -q -O tesidom.sh https://raw.githubusercontent.com/syakira09/Marzban-Dug-V1.1/main/tesidom.sh && chmod +x tesidom.sh && ./tesidom.sh
sleep 1
rm -r /etc/nginx/nginx.conf
wget -q -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/amarukael/config/main/nginx.conf"
service nginx restart
cd
wget -qO- https://surgahostinganaswae.com/scrip-chr/marzban/multi-port/v1.1/multi-portv1.1.tar.gz | tar xz --xform 's/multi-portv1.1/marzban/' && cd marzban
rm -r xray_config.json
wget -q -O /root/marzban/xray_config.json "https://raw.githubusercontent.com/amarukael/configig/main/config.json"
docker compose up -d
clear 
echo "Install telah selesai"
echo "Silahkan buka panel di http://domainmu:666/dashboard"
