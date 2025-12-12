VM Health Monitor — CPU / RAM / Disk Alerting System

A lightweight monitoring & alerting solution for Linux VMs using Bash, Systemd, Gmail/Outlook Email Alerts & Telegram Bot Notifications.

🚀 Overview

This project monitors CPU usage, Memory usage, and Disk usage on a Linux Virtual Machine and sends alerts when thresholds are crossed.
The system works entirely through Bash scripts + systemd timers, so it is extremely lightweight and requires no heavyweight monitoring agent.

You receive alerts instantly on:

📧 Email (Gmail using App Passwords)

📨 Telegram Bot (via Bot API)

The repository includes:

1)Automated health check script
2)Email alert engine (HTML formatted)
3)Telegram notification support
4)systemd service + timer for periodic execution (every minute)

✨ Features
✅ System Monitoring

1)CPU usage (%)
2)RAM usage (%)
3)Disk usage (root partition by default)

Top processes by CPU & Memory

✅ Alerting
Alerts are triggered when metrics exceed safe thresholds:
1)CPU > 85% → WARNING
2)CPU > 90% → CRITICAL
3)RAM > 85% → WARNING
4)RAM > 90% → CRITICAL
5)Disk > 85% → WARNING
6)Disk > 95% → CRITICAL

✅ Notification Channels
1)Email Alerts
2)Telegram Alerts
3)Recovery Alerts (when system returns to normal)

🧩 Designed for:
1)Personal VM monitoring
2)Student / Intern DevOps projects
3)Mini-projects for portfolio

Home labs & cloud instances (AWS, Azure, GCP, VMware, VirtualBox)

📁 Project Structure
vm-health-monitor/
├── vm_health_check.sh      # Main monitoring + alert script
├── disk-alert.service      # Systemd service
├── disk-alert.timer        # Systemd timer (runs every minute)
└── README.md               # Documentation

🛠️ Installation Guide
1️⃣ Clone the repository
git clone https://github.com/pbhavya009/vm-health-monitor.git
cd vm-health-monitor

2️⃣ Configure Email Alerts (Gmail or Outlook)
🔹 If using Gmail
->Enable 2-step verification
->Create an App Password
->Use that password in the script

🔹 If using Outlook

Go to:
Settings > Security > App Passwords > Generate password
Paste it into the script.

3️⃣ Edit your monitoring script
sudo nano /usr/local/bin/vm_health_check.sh


Set:
->Gmail/Outlook email
->App Password
->Telegram bot token - Chat ID

Then make the script executable:
sudo chmod +x /usr/local/bin/vm_health_check.sh

4️⃣ Install systemd service + timer

Copy files:
sudo cp disk-alert.service /etc/systemd/system/
sudo cp disk-alert.timer /etc/systemd/system/

Enable + start:
sudo systemctl daemon-reload
sudo systemctl enable --now disk-alert.timer

Verify:
systemctl status disk-alert.timer

5️⃣ Test the alert system manually
/usr/local/bin/vm_health_check.sh "Manual Test Trigger"

Check:

->Gmail/Outlook inbox
->Telegram messages
📬 Example Alert (Email)

Subject: [CRITICAL] VM Health Alert – bhavya-puri-VMware-Virtual-Platform
HTML-formatted body includes:
->CPU, RAM, Disk usage
->Hostname & timestamp
->Top CPU processes
->Top Memory processes
->Color-coded severity icons (🔥 ⚠️ 🟢)

📬 Example Telegram Output
🔥 *CPU CRITICAL*: Usage at 95%
Hostname: bhavya-puri-VMware-Virtual-Platform
Immediate action required!

🖥️ Kibana Dashboard (Optional)
If using Elastic Agent, you can visualize:
->CPU trend
->Memory trend
->Disk I/O
->Network packets
->Top resource-consuming processes
This is optional but helps with graphical monitoring.

🧪 Tested On
✔ Ubuntu 22.04
✔ Ubuntu 24.04
✔ Debian-based VMs
✔ VMware, VirtualBox, Cloud VMs

🤝 Contributing
Pull requests are welcome!
Feel free to open issues for bugs, enhancements, or features.

⭐ Support
If you like this project, consider giving the repository a GitHub Star ⭐
Your support helps improve and maintain this project.
