#!/bin/bash

source function.sh

loop=0
menuLogoView=12
while [[ $loop -eq 0 ]]; do

  if [[ $menuLogoView -eq 12 ]]; then
    menuLogo
    menuLogoView=13
  elif [[ $menuLogoView -eq 13 ]]; then
    echo =============================
  fi

  menuOptions

  num=$(getMenuNum)
  if [[ $num -eq 1 ]]; then
    viewMyDns
  elif [[ $num -eq 2 ]]; then
    dns_changer
  elif [[ $num -eq 3 ]]; then
    SelectDnsFromDatabase
  elif [[ $num -eq 4 ]]; then
    resetDns
  elif [[ $num -eq 5 ]]; then
    loop=1
    exit
  else
    echo "Enter the available options"
  fi

done
