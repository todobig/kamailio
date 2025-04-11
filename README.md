# Kamailio Auto Installer for Ubuntu 24.04

This script automates the installation of **Kamailio SIP Server** and essential modules on **Ubuntu 24.04 (Noble)**. It includes full logging, status checks, and safe error handling.

---

## 📦 What It Does

- Installs:
  - Kamailio core and modules (`mysql`, `tls`, `websocket`)
  - MariaDB (as SIP database backend)
- Adds official Kamailio 6.0 repository and GPG key
- Logs all steps to `kamailio_install.log`
- Exits on failure and shows clear messages

---

## 🧰 Requirements

- Ubuntu 24.04 LTS (Noble)
- Root privileges (`sudo`)
- Internet access

---

## ⚙️ Usage

### 1. Clone or download this repo

```bash
git clone https://github.com/todobig/kamailio.git
cd kamailio
