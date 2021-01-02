
printf "Installing RDP Be Patience... " >&2
{
sudo su
sudo apt-get update
wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
sudo dpkg --install chrome-remote-desktop_current_amd64.deb
sudo apt install --assume-yes --fix-broken
sudo DEBIAN_FRONTEND=noninteractive \
apt install --assume-yes xfce4 desktop-base
sudo bash -c 'echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session'  
sudo apt install --assume-yes xscreensaver
sudo systemctl disable lightdm.service
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg --install google-chrome-stable_current_amd64.deb
sudo apt install --assume-yes --fix-broken
sudo apt install nautilus nano -y 



toolsDir="/opt"
echo "[*] INSTALLING DEPENDENCIES IN \"$toolsDir\"..."

sudo mkdir -p "$toolsDir"

sudo apt install -y phantomjs xvfb dnsutils nmap

echo "[*] INSTALLING GO DEPENDENCIES (OUTPUT MAY FREEZE)..."

sudo wget -q -O - https://git.io/vQhTU | bash
sudo sleep 2
sudo source ~/.bashrc
sudo cd /usr/local
sudo wget https://golang.org/dl/go1.15.6.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.15.6.linux-amd64.tar.gz
sudo export PATH=$PATH:/usr/local/go/bin
sudo go get github.com/jaeles-project/jaeles
sudo go get -u github.com/KathanP19/Gxss
sudo go get -u github.com/lc/gau
sudo go get -u github.com/tomnomnom/gf
sudo go get -u github.com/jaeles-project/gospider
sudo go get -u github.com/projectdiscovery/httpx/cmd/httpx
sudo go get -u github.com/tomnomnom/qsreplace
sudo go get -u github.com/haccer/subjack
sudo go get -u github.com/tomnomnom/assetfinder
sudo go get github.com/hakluke/hakrawler
sudo go get -u github.com/OWASP/Amass/v3/...
sudo go get -u github.com/ffuf/ffuf
sudo go get -u github.com/ethicalhackingplayground/bxss
sudo git clone https://github.com/projectdiscovery/httpx.git; cd httpx/cmd/httpx; go build; mv httpx /usr/local/bin/; httpx -version
sudo cd $GOPATH/src/github.com/OWASP/Amass
sudo go install ./...


sudo echo "[*] INSTALLING RUSTSCAN..."

sudo wget https://github.com/RustScan/RustScan/releases/download/2.0.1/rustscan_2.0.1_amd64.deb
sudo dpkg -i rustscan_2.0.1_amd64.deb

sudo echo "[*] INSTALLING GIT DEPENDENCIES..."

sudo git clone https://github.com/hahwul/dalfox
sudo cd dalfox
sudo go install
sudo go build
sudo cd ~/
sudo git clone https://github.com/chvancooten/BugBountyScanner
cd ~/BugBountyScanner
sudo wget https://raw.githubusercontent.com/aali99/BugBountyScanner/master/.env
sudo rm -rf .env.example
sudo echo "fitbit.com,elastifile.com,spokeo.com" >programs.txt
### Nuclei (Workaround -https://github.com/projectdiscovery/nuclei/issues/291)
sudo cd "$toolsDir" || { echo "Something went wrong"; exit 1; }
sudo git clone -q https://github.com/projectdiscovery/nuclei.git
sudo cd nuclei/v2/cmd/nuclei/ || { echo "Something went wrong"; exit 1; }
sudo go build
sudo mv nuclei /usr/local/bin/

### Nuclei templates
sudo cd "$toolsDir" || { echo "Something went wrong"; exit 1; }
sudo git clone -q https://github.com/projectdiscovery/nuclei-templates.git
sudo nuclei --update-templates 
### Gf-Patterns
sudo cd "$toolsDir" || { echo "Something went wrong"; exit 1; }
sudo git clone -q https://github.com/1ndianl33t/Gf-Patterns
sudo mkdir ~/.gf
sudo cp "$toolsDir"/Gf-Patterns/*.json ~/.gf

sudo pip3 install telegram-send

sudo echo "[*] SETUP FINISHED."

} &> /dev/null &&
printf "\nSetup Complete " >&2 ||
printf "\nError Occured " >&2
printf '\nCheck https://remotedesktop.google.com/headless  Copy Command Of Debian Linux And Paste Down\n'
read -p "Paste Here: " CRP

printf 'Check https://remotedesktop.google.com/access/ \n\n'
if sudo apt-get upgrade &> /dev/null
then
    printf "\n\nUpgrade Completed " >&2
else
    printf "\n\nError Occured " >&2
fi
