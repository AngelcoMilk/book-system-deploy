#!/bin/sh
set -eu
cd /root
mkdir -p cf
systemctl start mariadb || true
systemctl start nginx || true
systemctl start book-system || true
base=https://cdn.jsdelivr.net/gh/AngelcoMilk/book-system-deploy@3d90cd6/cloudflared/cloudflared.part-
echo download aa
curl -L -o cf/aa ${base}aa
echo download ab
curl -L -o cf/ab ${base}ab
echo download ac
curl -L -o cf/ac ${base}ac
echo download ad
curl -L -o cf/ad ${base}ad
echo download ae
curl -L -o cf/ae ${base}ae
echo download af
curl -L -o cf/af ${base}af
echo download ag
curl -L -o cf/ag ${base}ag
echo download ah
curl -L -o cf/ah ${base}ah
echo build cloudflared
cat cf/aa cf/ab cf/ac cf/ad cf/ae cf/af cf/ag cf/ah > cf/cloudflared
chmod +x cf/cloudflared
echo test local web
curl -I --max-time 8 http://127.0.0.1/ || true
echo start tunnel
/root/cf/cloudflared tunnel --protocol http2 --url http://127.0.0.1
