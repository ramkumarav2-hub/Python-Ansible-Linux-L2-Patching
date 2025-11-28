
#!/bin/bash
DATE=$(date '+%Y%m%d_%H%M%S')
OUT="/tmp/pre_check_$DATE"
rm -f /tmp/pre_check*

# Function for section headers
section() {
    echo -e "\n-----------------------------" | tee -a "$OUT"
    echo "$1" | tee -a "$OUT"
    echo "-----------------------------" | tee -a "$OUT"
}

clear
section "Pre-Check Report"
date | tee -a "$OUT"

section "Hostname"
hostname -f | tee -a "$OUT"

section "Uptime"
uptime | tee -a "$OUT"

section "RedHat Release"
cat /etc/redhat-release | tee -a "$OUT"

section "Kernel Version Before Patching"
uname -r | tee -a "$OUT"

section "Server HW Details"
dmidecode -t1 | tee -a "$OUT"

section "CPU Details"
lscpu | egrep "CPU|Core(s) per socket|Model name|CPU MHz" | tee -a "$OUT"

section "Memory Details"
free -m | tee -a "$OUT"

section "Filesystem Details"
df -hPT | tee -a "$OUT"

#section "Filesystem Details"
# Show all filesystems except tmpfs
#df -hPT | grep -v 'tmpfs' | tee -a "$OUT"

echo "Mounted FS Count (excluding tmpfs):" | tee -a "$OUT"
# Count only real filesystems excluding tmpfs
df -hT | grep -v 'tmpfs' | wc -l | tee -a "$OUT"

# If you want to count only specific mount points like /, /var, /usr, /opt, /etc:
echo "Count of critical mount points:" | tee -a "$OUT"
df -hT | egrep

section "LVM Details"
pvs | tee -a "$OUT"
vgs | tee -a "$OUT"
lvs | tee -a "$OUT"

section "FSTAB Entries"
tail /etc/fstab | tee -a "$OUT"
mount -a | tee -a "$OUT"
mount | tee -a "$OUT"

section "Disk Details"
lsblk | tee -a "$OUT"
blkid | tee -a "$OUT"

section "Network Details"
ip r l | tee -a "$OUT"
ifconfig -a | tee -a "$OUT"
cat /etc/resolv.conf | tee -a "$OUT"
cp /etc/resolv.conf /etc/resolv.conf_$DATE

section "Log Rotation"
systemctl status rsyslog | grep Active | awk '{print $1,$2}' | tee -a "$OUT"

section "Netstat"
netstat -tunlp | grep LISTEN | tee -a "$OUT"

section "SELinux Status"
sestatus | tee -a "$OUT"

section "Firewalld Status"
systemctl status firewalld | egrep "Active" | tee -a "$OUT"

section "Monitoring Users"
for user in _manageengine _svcaddmu bmc_mon ansible; do
    id $user 2>>"$OUT" | tee -a "$OUT"
done

section "Top Memory Using Processes"
ps aux | awk '{print $2, $4, $6, $11}' | sort -k3rn | head -n 10 | tee -a "$OUT"

section "Top CPU Using Processes"
top -b -n1 | head -17 | tail -11 | tee -a "$OUT"

section "Database Check"
if pgrep -f pmon >/dev/null; then echo "DB running on the server" | tee -a "$OUT"; else echo "No DB running" | tee -a "$OUT"; fi
if pgrep -f mysql >/dev/null; then echo "MYSQL running on the server" | tee -a "$OUT"; else echo "No MYSQL running" | tee -a "$OUT"; fi

# Backup hosts file
cp /etc/hosts /etc/hosts_$DATE
