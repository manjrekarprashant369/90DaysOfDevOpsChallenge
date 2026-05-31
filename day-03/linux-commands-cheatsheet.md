# Linux Commands Cheat Sheet

## ⚙️ Process Management
**Manage system resources, view running tasks, and control process execution.**

| Command | Description |
| --- | --- |
| `top` or `htop` | Display real-time, interactive views of running processes and resource consumption. |
| `ps aux`  | List all currently running processes with detailed info and user ownership. |
| `ps aux --sort=-%cpu ! head`  | Show the top processes consuming the highest CPU. |
| `kill <PID>` | Gracefully terminate a process by its Process ID. |
| `kill -9 <PID>` | Force-kill an unresponsive process. |
| `pkill <process_name>` | Terminate all processes matching a specific name. |
| `jobs`  |  List background jobs in current shell. |
|  `bg %1`  / `fg %1`  | Put a suspended process in the background or bring it to the foreground. |
| `renice <PID>`  | Change priority of running process. |

## 📂 File System
**Navigate directories, check disk space, and manage file permissions.**

| Command | Description |
| --- | --- |
| `df -h` | Display human-readable disk space usage for all mounted drives. |
| `du -sh *`  | View human-readable disk usage for files and folders in the current directory. |
| `lsblk` |  List block devices and partitions in a tree format to see connected disks. |
| `df -i` |  Check inode usage (useful for "No Space Left on Device" errors despite free space). |
| `chmod 755 <filename>` |  Change file permissions (e.g., read, write, execute). |
| `chown <user>:<group> <filename>` | Change file owner and group ownership. |
| `find /path -name "<filename>"` | Locate a file or directory by its name. |

## 🌐 Networking Troubleshooting
**Test connectivity, inspect open ports, and resolve network issue.**

| Command | Description |
| --- | --- |
| `ip addr`  | View all network interfaces, IP addresses, and link states. |
| `ping <host>` | Test network and internet connectivity to a host or IP. |
| `ss -tulpn` | Display all listening TCP and UDP ports and their associated process names (a modern replacement for `netstat`). |
| `curl -I <url>` | Fetch the HTTP headers of a web page to check server response status. |
| `traceroute <host>` | Trace the hops and path packets take to reach a destination. |
| `nslookup <host>` | Query DNS servers to resolve IP addresses or check DNS configuration. |
| `systemctl restart <service>` |  Restart a failing network service (e.g., `sshd` or `networking`). |

### Reference: 
https://www.geeksforgeeks.org/linux-unix/linux-commands-cheat-sheet/