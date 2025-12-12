VM Health Monitor

Automated CPU, RAM & Disk Monitoring + Gmail/Telegram Alerts + Systemd Scheduler

![GitHub stars](https://img.shields.io/github/stars/pbhavya009/vm-health-monitor?style=flat-square)
![GitHub forks](https://img.shields.io/github/forks/pbhavya009/vm-health-monitor?style=flat-square)
![Top Language](https://img.shields.io/github/languages/top/pbhavya009/vm-health-monitor)
![Last Commit](https://img.shields.io/github/last-commit/pbhavya009/vm-health-monitor)

---

Overview

**VM Health Monitor** is a lightweight Linux monitoring solution that tracks:

* **CPU Usage**
* **RAM Usage**
* **Disk Usage**
* **Top Processes (CPU & Memory)**
* **System Load Trends**

It automatically sends alerts to:

### 🔔 Supported Notification Channels:

* **📧 Gmail (App Password Based)**
* **🤖 Telegram Bot (Instant Push Alerts)**

It also runs **every minute** using a systemd timer and logs system health continuously.

---

## 📚 Table of Contents

1. [Features](#-features)
2. [Architecture](#-architecture)
3. [Screenshots](#-screenshots)
4. [Installation](#-installation)
5. [Configuration](#-configuration)
6. [Systemd Setup](#-systemd-setup)
7. [Troubleshooting](#-troubleshooting)
8. [Contributing](#-contributing)
9. [License](#-license)

---

## ✅ Features

### 🔍 **Monitoring**

* Detects **CPU spikes**
* Detects **Memory high usage**
* Detects **Low Disk Space**
* Provides **top CPU-consuming processes**
* Provides **top Memory-consuming processes**

### 🔔 **Alerts**

* **Warning**, **Danger**, and **Safe** recovery alerts
* Sends notifications via:

  * Gmail
  * Telegram bot

### ⚙️ **Automation**

* Runs every minute via systemd service + timer
* Lightweight (written in pure Bash)

---

## 🏗 Architecture

```
vm_health_check.sh     → Core script for monitoring + alerts
send_gmail_alert.sh     → Sends notifications to Gmail
disk-alert.service      → Service file for systemd
disk-alert.timer        → Timer to execute script every 1 minute
```

---

## 🖼 Screenshots

### 🔹 **VM Dashboard (Kibana)**
Example:
<img width="1920" height="1080" alt="Dashboard 1" src="https://github.com/user-attachments/assets/51ab1cd4-b708-409c-adfc-0f20f15ce844" />
<img width="1920" height="1080" alt="Dashboard 2" src="https://github.com/user-attachments/assets/f816228c-ba26-48c9-b9b2-ff349e05dc73" />


### 🔹 **Telegram Alerts**
<img width="960" height="540" alt="Telegram 1" src="https://github.com/user-attachments/assets/adfaf581-7dfe-46b3-82ba-c57c6bd2f4e5" />


### 🔹 **Email Alerts (Gmail)**
<img width="1920" height="1080" alt="Gmail 1" src="https://github.com/user-attachments/assets/e6defdcf-931e-4f20-a55e-57e8d84858ff" />

---

## 🛠 Installation

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/pbhavya009/vm-health-monitor.git
cd vm-health-monitor
```

### 2️⃣ Install Dependencies

```bash
sudo apt install sendemail libio-socket-ssl-perl libnet-ssleay-perl -y
```

---

## ⚙️ Configuration

### 1️⃣ Set Gmail App Password

Go to:
`Google Account → Security → App Passwords → Generate Password`

Update inside:

```
send_gmail_alert.sh
```

### 2️⃣ Set Telegram Bot Token & Chat ID

Replace values inside the script:

```
BOT_TOKEN="xxxxxxxx"
CHAT_ID="xxxxxxxx"
```

### 3️⃣ Make Scripts Executable

```bash
sudo chmod +x vm_health_check.sh
sudo chmod +x send_gmail_alert.sh
```

---

## ⏱ Systemd Setup

Copy service + timer:

```bash
sudo cp disk-alert.service /etc/systemd/system/
sudo cp disk-alert.timer /etc/systemd/system/
```

Enable & start timer:

```bash
sudo systemctl daemon-reload
sudo systemctl enable disk-alert.timer
sudo systemctl start disk-alert.timer
```

Check status:

```bash
systemctl status disk-alert.timer
```

---

## 🧪 Manual Test

```bash
bash vm_health_check.sh "Manual Test Alert"
```

You should receive alerts on Gmail & Telegram.

---

## 🩺 Troubleshooting

### ❌ Gmail: Authentication Failed

* Ensure App Password is correct
* 2FA must be ON
* Username must match sender email

### ❌ Telegram Bot Not Sending Messages

* Check BOT_TOKEN and CHAT_ID
* Try:

```bash
curl -X GET "https://api.telegram.org/bot<TOKEN>/getUpdates"
```

### ❌ Script Not Running Automatically

Check timer logs:

```bash
journalctl -u disk-alert.service --no-pager --since "5 min ago"
```

---

## 🤝 Contributing

PRs are welcome!
If you want to add features like:

* CPU graphs
* Log history
* Web dashboard

Feel free to fork & submit a pull request.

---

## ⭐ Support the Project

If this project helped you — **please star the repo** ⭐
It motivates future improvements!
