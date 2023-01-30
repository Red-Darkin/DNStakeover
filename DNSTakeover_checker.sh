#!/bin/bash

#Colors
RED='\033[1;31m'
GREEN='\033[1;32m'
CYAN='\033[1;36m'
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
PURPLE='\033[1;35m'
NC='\033[0m'


#Help Func
Help()
{
echo -e "${BLUE}[*] Syntax: ${CYAN}./DNStakeover_checker.sh -d example.com${NC} or ${PURPLE}bash DNStakeover_checker.sh -d example.com${NC}" 

}


#Program Func
Check()
{
ns_name=$(dig $domain +trace | grep -E "ns[0-9]|ns-[0-9]|*\.ns|ns-*\.*\.*" | grep -v "NSEC3" | grep -v "global" | grep -v "Received" | awk '{print $5}' | sort -u > NS_record)

for i in $(cat NS_record); 
        do
        echo -e "\n${GREEN}[*] $i:${NC}";
        dig @$i $domain | grep status | awk '{print$5,$6}'| tr ',' ' ';
        done

echo -e "\nIf the status is '${YELLOW}REFUSED${NC}' or '${YELLOW}SERVFAIL${NC}' the domain is vulnerable"

rm NS_record
}



while getopts ":hd:" option; do
   case $option in
      h) # display Help
         Help
         exit;;
      d) domain=${OPTARG}
	Check
	exit;;
      \?) # incorrect option
         echo -e "${RED}Error: Invalid option, check [-h] option${NC}"
         exit;;
   esac
done

#For read files run the next command:
#for i in $(cat domain.txt); do echo "$i:"; bash DNSTakeover_checker.sh -d $i; done
