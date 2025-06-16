#!/bin/bash

# MIT License
# Copyright (c) 2025 Gh0stlyKn1ght
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

set -e

VERSION="1.0"
DATE="2025-06-15"
TOOLS_DIR="$HOME/osint-tools"
LOGFILE="osint-install-errors.log"

mkdir -p "$TOOLS_DIR"
cd "$TOOLS_DIR"

# Colors
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
PURPLE='\033[1;35m'
NC='\033[0m'

function banner() {
    echo -e "${PURPLE}\n[*] $1...${NC}"
}

function skip_error() {
    echo -e "${RED}[!] $1 – skipping.${NC}"
    echo "[!] $1" >> "$LOGFILE"
}

function safe_git_clone() {
    local repo=$1
    local folder=$2
    if [ -d "$folder" ]; then
        echo -e "${YELLOW}[!] $folder already exists, skipping clone.${NC}"
        return 0
    fi
    git clone "$repo" "$folder" 2>/dev/null || {
        skip_error "$repo (clone failed – repo may not exist or is private)"
        return 1
    }
}

function install_prereqs() {
    banner "Checking system prerequisites"
    sudo apt update -y
    sudo apt install -y git python3 python3-pip nodejs npm golang-go cargo \
        firefox-esr tor stegosuite httrack exiv2 xpdf libimage-exiftool-perl
}

function install_python_requirements() {
    local dir=$1
    if [ -f "$dir/requirements.txt" ]; then
        pip3 install --break-system-packages -r "$dir/requirements.txt" || skip_error "$dir (pip install failed)"
    fi
}

function safe_install() {
    local name=$1
    local func=$2
    local i=$3
    local total=$4

    if command -v "$name" &>/dev/null || [ -d "$TOOLS_DIR/$name" ]; then
        echo -e "${YELLOW}[$i/$total] $name already installed, skipping.${NC}"
        return
    fi

    echo -ne "${PURPLE}[$i/$total] Installing $name...${NC}\r"
    sleep 0.3
    $func
    echo -e "${GREEN}[$i/$total] $name installation complete.${NC}"
}

function install_amass() {
    sudo apt install -y amass || skip_error "Amass"
}

function install_reconftw() {
    safe_git_clone https://github.com/six2dez/reconftw.git reconftw || return
    cd reconftw && chmod +x install.sh && sudo ./install.sh || skip_error "ReconFTW"
    cd ..
}

function install_photon() {
    safe_git_clone https://github.com/s0md3v/Photon.git Photon || return
    install_python_requirements "Photon"
}

function install_sn0int() {
    cargo install sn0int || skip_error "sn0int"
}

function install_social_analyzer() {
    safe_git_clone https://github.com/qeeqbox/social-analyzer.git social-analyzer || return
    install_python_requirements "social-analyzer"
}

function install_ghunt() {
    safe_git_clone https://github.com/mxrch/GHunt.git GHunt || return
    install_python_requirements "GHunt"
}

function install_holehe() {
    pip3 install --break-system-packages holehe || skip_error "Holehe"
}

function install_blackbird() {
    safe_git_clone https://github.com/p1ngul1n0/blackbird.git blackbird || return
    install_python_requirements "blackbird"
}

function install_osintgram() {
    safe_git_clone https://github.com/Datalux/Osintgram.git Osintgram || return
    install_python_requirements "Osintgram"
}

function install_wayback() {
    go install github.com/tomnomnom/waybackurls@latest || skip_error "waybackurls"
    go install github.com/lc/gau@latest || skip_error "gau"
}

function install_shodan() {
    pip3 install --break-system-packages shodan || skip_error "Shodan CLI"
}

function install_youtubedl() {
    pip3 install --break-system-packages youtube-dl || skip_error "youtube-dl"
}

function install_phoneinfoga() {
    safe_git_clone https://github.com/sundowndev/phoneinfoga.git phoneinfoga || return
    install_python_requirements "phoneinfoga"
}

function install_tiktok_scraper() {
    if ! sudo npm install -g tiktok-scraper; then
        skip_error "TikTok Scraper (npm permissions issue)"
    fi
}

function install_all() {
    local tools=(
        "amass:install_amass"
        "reconftw:install_reconftw"
        "Photon:install_photon"
        "sn0int:install_sn0int"
        "social-analyzer:install_social_analyzer"
        "GHunt:install_ghunt"
        "holehe:install_holehe"
        "blackbird:install_blackbird"
        "OSINTgram:install_osintgram"
        "waybackurls:install_wayback"
        "shodan:install_shodan"
        "youtube-dl:install_youtubedl"
        "phoneinfoga:install_phoneinfoga"
        "tiktok-scraper:install_tiktok_scraper"
    )
    install_prereqs
    local total=${#tools[@]}
    local i=1
    for entry in "${tools[@]}"; do
        IFS=":" read -r name func <<< "$entry"
        safe_install "$name" "$func" "$i" "$total"
        i=$((i + 1))
    done
    echo -e "\n${GREEN}[*] All tools processed. Check $LOGFILE for any errors.${NC}"
    exit 0
}

install_all
