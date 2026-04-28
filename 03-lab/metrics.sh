#!/bin/bash

# ---------------- CPU ----------------
cpu=$(top -bn1 | awk -F',' '/Cpu/ {for(i=1;i<=NF;i++){if($i ~ /id/){split($i,a," "); print 100 - a[1]}}}')

# ---------------- RAM ----------------
ram_pct=$(free -m | awk '/Mem:/ {printf("%.1f", $3*100/$2)}')
ram_text=$(free -m | awk '/Mem:/ {printf("%d MB / %d MB", $3, $2)}')

# ---------------- DISK ----------------
disk_pct=$(df -h / | awk 'NR==2 {gsub("%","",$5); print $5}')
disk_text=$(df -h / | awk 'NR==2 {print $3 " Used of " $2}')

# ---------------- OUTPUT ----------------
echo "$cpu"
echo "$ram_pct"
echo "$ram_text"
echo "$disk_pct"
echo "$disk_text"