#!/bin/bash

set -euo pipefail
LOG_FILE="kamailio_install.log"
exec > >(tee -a "$LOG_FILE") 2>&1

echo "========== KAMAILIO INSTALLATION STARTED =========="
echo "Date: $(date)"
echo "User: $(whoami)"
echo "System: $(lsb_release -d -s)"
echo "===================================================="
echo ""

log_step() {
    echo "---- $1 ----"
}

check_step() {
    if [ $? -eq 0 ]; then
        echo "[ OK ] $1"
    else
        echo "[ FAIL ] $1"
        exit 1
    fi
}

# 1. System update
log_step "1. Updating package list"
sudo apt update
check_step "Package list updated"

# 2. Installing MariaDB
log_step "2. Installing MariaDB"
sudo apt install -y mariadb-server
check_step "MariaDB installed"

# 3. Adding Kamailio GPG Key
log_step "3. Adding Kamailio GPG key"
wget -O- http://deb.kamailio.org/kamailiodebkey.gpg | sudo apt-key add -
check_step "Kamailio GPG key added"

# 4. Adding Kamailio APT repository
log_step "4. Adding Kamailio APT repository"
cat <<EOF | sudo tee /etc/apt/sources.list.d/kamailio.list
deb     http://deb.kamailio.org/kamailio60 noble main
deb-src http://deb.kamailio.org/kamailio60 noble main
EOF
check_step "Kamailio repo added"

# 5. Updating after adding repo
log_step "5. Updating after adding Kamailio repo"
sudo apt update
check_step "Repo update completed"

# 6. Installing Kamailio and modules
log_step "6. Installing Kamailio core and common modules"
sudo apt install -y kamailio kamailio-mysql-modules kamailio-websocket-modules kamailio-tls-modules
check_step "Kamailio core and modules installed"

# 7. Version check
log_step "7. Verifying Kamailio version"
kamailio -V || { echo "[ FAIL ] Kamailio version check failed"; exit 1; }
check_step "Kamailio version verified"

echo ""
echo "========== KAMAILIO INSTALLATION COMPLETED =========="
echo "You can now configure Kamailio via /etc/kamailio/"
echo "Log saved to: $LOG_FILE"
