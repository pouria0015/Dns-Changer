#!/bin/bash

menuLogo(){


echo █████████████████████████████▀█████████████████████████████
echo █─▄▄▄─█─█─██▀▄─██▄─▀█▄─▄█─▄▄▄▄█▄─▄▄─███▄─▄▄▀█▄─▀█▄─▄█─▄▄▄▄█
echo █─███▀█─▄─██─▀─███─█▄▀─██─██▄─██─▄█▀████─██─██─█▄▀─██▄▄▄▄─█
echo ▀▄▄▄▄▄▀▄▀▄▀▄▄▀▄▄▀▄▄▄▀▀▄▄▀▄▄▄▄▄▀▄▄▄▄▄▀▀▀▄▄▄▄▀▀▄▄▄▀▀▄▄▀▄▄▄▄▄▀
echo -e '\n'

}

menuOptions(){
  echo 1: view my DNS
  echo 2: change DNS
  echo 3: select DNS from databse
  echo 4: reset Dns
  echo -e "5: exit\n"
}

getMenuNum(){

  local Num=$1
  read -p "Enter the option: " Num
  echo ${Num}

}

dns_changer() {
echo "" |  sudo cp /etc/resolv.conf /etc/resolv.con.backup


read -p "Enter Dns Ip1: " dns1
read -p "Enter Dns Ip2: " dns2

if  [[ $dns1 =~ ^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$ ]] ||  [[ $dns2 =~ ^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$ ]]; then

echo -e "\n\nDns:\n"
echo "# Generated by NetworkManager" | sudo tee /etc/resolv.conf
echo nameserver $dns1 | sudo tee -a /etc/resolv.conf
if [ ! -z "$dns2" -a  "$dns2" != " " ]; then
echo nameserver $dns2 | sudo tee -a  /etc/resolv.conf
fi
if [[ $? -eq 0 ]]; then

echo -e "\nsuccess"

else

echo -e "\nNot Success"

fi

else
  echo -e "\n Not valid Dns"
fi

}


viewMyDns(){

  echo -e "\nYour Dns:\n" | sudo cat /etc/resolv.conf
  echo -e "\n\n"

}

SelectDnsFromDatabase(){


  dns_file="./database/DnsDatabse.txt"



if [ ! -f "$dns_file" ]; then
    echo "Error: DNS database file not found."
    exit 1
fi


echo "DNS servers list:"
cut -d ':' -f 1 "$dns_file"

echo -e "\n"
read -p "Enter DNS server: " selected_dns


if grep -q "^$selected_dns:" "$dns_file"; then

  selected_ips=$(grep "^$selected_dns:" "$dns_file" | cut -d ':' -f2-)

  ip1=$(echo "$selected_ips" | cut -d ':' -f1)
  ip2=$(echo "$selected_ips" | cut -d ':' -f2)

    echo -e "\n\nDns:\n"

    echo "# Generated by NetworkManager" | sudo tee /etc/resolv.conf
    echo "nameserver $ip1" | sudo tee -a /etc/resolv.conf
    if [ ! -z "$ip2" -a "$ip2" != " "];then
    echo "nameserver $ip2" | sudo tee -a /etc/resolv.conf
    fi
    echo -e "\nDNS servers set successfully.\n"
else
    echo "Error: Selected DNS server is not valid."
fi


}

resetDns(){

fileNameBackUpDns="/etc/resolv.con.backup"
fileNameOutput="/etc/resolv.conf"
if [[ ! -f "$fileNameBackUpDns" ]];then

echo file not found!
exit 1

fi

> "$fileNameOutput"
while IFS= read -r line;do
  echo "$line" >> "$fileNameOutput"
done < "$fileNameBackUpDns"

}
