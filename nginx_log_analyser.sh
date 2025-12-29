Logs_file=$1

echo "======================================"
echo "TOP 5 DES IPs AVEC LE PLUS DE REQUESTS"
echo "======================================"

awk '{print $1}' $Logs_file | sort | uniq -c | sort -n -r | head -5 | awk '{print $2 " - " $1 " requests"}'


echo "======================================"
echo "TOP 5 DES PATH LES PLUS UTILISE"
echo "======================================"

awk '{print $7}' nginx.log | sort | uniq -c | sort -n -r | head -5 | awk '{print $2 " - " $1 " requests"}'


echo "======================================"
echo "TOP 5 STATUS CODE LES PLUS FREQUENTS"
echo "======================================"

awk '{print $9}' nginx.log | grep -v '"-"' | sort | uniq -c | sort -n -r | head -5 | awk '{print $2 " - " $1 " requests"}'
