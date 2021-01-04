#!/bin/bash
## Automated Bug Bounty recon script dependency installer
## By Cas van Cooten

### NOTE: This installation script is deprecated by the implementation of the Dockerfile. Not all dependencies may automatically work.

for arg in "$@"
do
    case $arg in
        -h|--help)
        echo "BugBountyHunter Dependency Installer"
        echo " "
        echo "$0 [options]"
        echo " "
        echo "options:"
        echo "-h, --help                show brief help"
        echo "-t, --toolsdir            tools directory, defaults to '/opt'"
        echo ""
        echo "Note: If you choose a non-default tools directory, please adapt the default in the BugBountyAutomator.sh file or pass the -t flag to ensure it finds the right tools."
        echo " "
        echo "example:"
        echo "$0 -t /opt"
        exit 0
        ;;
        -t|--toolsdir)
        toolsDir="$2"
        shift
        shift
        ;;
    esac
done

if [ -z "$toolsDir" ]
then
    toolsDir="/opt"
fi

echo "[*] INSTALLING DEPENDENCIES IN \"$toolsDir\"..."

mkdir -p "$toolsDir"

apt install -y phantomjs xvfb dnsutils nmap


sleep 3

echo "[*] INSTALLING GO DEPENDENCIES (OUTPUT MAY FREEZE)..."
#sudo wget -q -O - https://git.io/vQhTU | bash
#sudo sleep 5
#su -c source ~/.bashrc
#su -c source ~/\.bashrc
#cd /usr/local
#wget https://golang.org/dl/go1.15.6.linux-amd64.tar.gz
#tar -C /usr/local -xzf go1.15.6.linux-amd64.tar.gz
#export PATH=$PATH:/usr/local/go/bin
go get -u github.com/tomnomnom/anew
go get -v github.com/dwisiswant0/crlfuzz/cmd/crlfuzz
go get github.com/jaeles-project/jaeles
jaeles config init
sleep 2
go get -u github.com/KathanP19/Gxss
go get -u github.com/lc/gau
go get -u github.com/tomnomnom/gf
go get -u github.com/jaeles-project/gospider
go get -u github.com/tomnomnom/qsreplace
sleep 2
go get -u github.com/haccer/subjack
go get -u github.com/tomnomnom/assetfinder
go get github.com/hakluke/hakrawler
sleep 2
go get -u github.com/ffuf/ffuf
go get -u github.com/ethicalhackingplayground/bxss
git clone https://github.com/projectdiscovery/httpx.git; cd httpx/cmd/httpx; go build; mv httpx /usr/local/bin/; httpx -version
cd $GOPATH/src/github.com/OWASP/Amass
go install ./...
sleep 1

apt install screen 
echo "[*] INSTALLING RUSTSCAN..."
cd ~
wget https://github.com/RustScan/RustScan/releases/download/2.0.1/rustscan_2.0.1_amd64.deb
dpkg -i rustscan_2.0.1_amd64.deb

sleep 3

echo "[*] INSTALLING GIT DEPENDENCIES..."

git clone https://github.com/hahwul/dalfox
cd dalfox
go install
go build

sleep 3

cd ~
git clone https://github.com/aali99/scrpt
cd ~/scrpt
cp raftseclist.txt ~/
cd ~
git clone https://github.com/chvancooten/BugBountyScanner
sleep 1
cd ~/BugBountyScanner/
wget https://raw.githubusercontent.com/aali99/BugBountyScanner/master/.env
rm -rf .env.example
echo "fitbit.com,elastifile.com,spokeo.com,asana.biz,asana.plus,app.asana.com,form.asana.com,bina.com,intermune.com,genia.com,roche-applied-science.com,accu-chek.com,coaguchek.com,roche-diagnostics.fr,roche-diagnostics.co.in,roche-diagnostics.com,cobas.com,accu-chekinsulinpumps.com,rocheindia.com,roche.co.uk,lucentisdirect.com,lucentis.com,ariosadx.com,kapabiosystems.com,navify.com,hyperdesign.com,mysugr.com,viewics.com,sparktx.com,clinical-services.net,foundationmedicine.com,foundationmedicine.ph,stratosgenomics.com,roche.com,ventana.com,sameh23.jfrog.com,gene.com
" >programs.txt
cp ~/scrpt/ghgh.sh ./
chmod +x ghgh.sh
### Nuclei (Workaround -https://github.com/projectdiscovery/nuclei/issues/291)
sleep 2
cd "$toolsDir" || { echo "Something went wrong"; exit 1; }
git clone -q https://github.com/projectdiscovery/nuclei.git
cd nuclei/v2/cmd/nuclei/ || { echo "Something went wrong"; exit 1; }
go build
mv nuclei /usr/local/bin/

### Nuclei templates
cd "$toolsDir" || { echo "Something went wrong"; exit 1; }
git clone -q https://github.com/projectdiscovery/nuclei-templates.git
nuclei --update-templates 
### Gf-Patterns
cd "$toolsDir" || { echo "Something went wrong"; exit 1; }
git clone -q https://github.com/1ndianl33t/Gf-Patterns
mkdir ~/.gf
cp "$toolsDir"/Gf-Patterns/*.json ~/.gf

pip3 install telegram-send

echo "[*] SETUP FINISHED."

screen -S hunt

#sameh101010x
#-1001324393196
#1448371821:AAHLFabz4VA5QNfcBAtR5JEN3dtbU6s8v8c
