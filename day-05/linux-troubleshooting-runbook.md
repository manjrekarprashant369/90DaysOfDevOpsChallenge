# Day 05 – Linux Troubleshooting Drill: CPU, Memory, and Logs

**Goal:** The goal is not just running commands but building a repeatable troubleshooting workflow that can be used during real incidents.

## Target Service / Process Used During Drill

- **Service:** Docker
- **Reason:** Docker is a critical runtime service used for running containers and application workloads.

---

## Environment Basics

### 1. OS Information 

```bash
uname -a
```

**Output:**

![snapshot](screenshots/1_uname.png)

**Observation:**
- System is running Ubuntu Linux kernel 6.17
- No immediate kernel-related concerns observed.

### 2. Distribution Information

```bash
cat /etc/os-release
```

**Output:**

![snapshot](screenshots/2_os_release.png)

**Observation:**
- Host OS is Ubuntu 24.04 LTS.
- Useful when verifying package compatibility and troubleshooting known OS issues.

---

## Filesystem Sanity Checks

### 3. Create Temporary Working Directory

```bash
mkdir -p /tmp/runbook-demo
```

**Output:**

![snapshot](screenshots/3_mkdir_runbook_demo.png)

**Observation:**
- Temporary troubleshooting directory created successfully.
- Confirms write access to filesystem.

### 4. Copy and Verify File

```bash
cp /etc/hosts /tmp/runbook-demo/hosts-copy && ls -l /tmp/runbook-demo
```

**Output:**

![snapshot](screenshots/4_cp_etc_host.png)

**Observation:**
- File copy operation completed successfully.
- No filesystem permission issues detected.

---

## Snapshot: CPU & Memory

### 5. Inspect Docker Process Usage

```bash
ps -o pid,pcpu,pmem,comm -C dockerd
```

**Output:**

![snapshot](screenshots/5_docker_process_usage.png)

**Observation:**
- Docker daemon consuming minimal CPU.
- Memory usage appears healthy.

### 6. Memory Status

```bash
free -h
```

**Output:**

![snapshot](screenshots/6_memory_status.png)

**Observation:**
- Healthy memory availability.
- Swap is not being utilized.

---

## Snapshot: Disk & IO

### 7. Filesystem Capacity

```bash
df -h
```

**Output:**

![snapshot](screenshots/7_filesystem_capacity.png)

**Observation:**
- Root filesystem below 50% utilization.
- No immediate disk-space concern.

### 8. Log Directory Usage

```bash
du -sh /var/log
```

**Output:**

![snapshot](screenshots/8_log_directory_usage.png)

**Observation:**
- Log directory size is reasonable.
- No abnormal log growth detected.

### 9. Virtual Memory Statistics

```bash
vmstat 1 5
```

**Output:**

![snapshot](screenshots/9_virtual_memory_statistics.png)

**Observation:**
- No CPU wait state issues.
- No swapping activity observed.

---

## Snapshot: Network

### 10. Listening Ports

```bash
ss -tulpn | grep docker
```

**Output:**

![snapshot](screenshots/10_docker_port_listening.png)

**Observation:**
- Docker service is listening on expected port.
- Service is reachable locally.

### 11. Service Reachability

```bash
curl -I http://localhost:2375
```

**Output:**

![snapshot](screenshots/11_service_reachability.png)

**Observation:**
- Local service endpoint responding successfully.
- No immediate connectivity issues.

---

## Logs Reviewed

### 12. Docker Service Logs

```bash
journalctl -u docker -n 50 --no-pager
```

**Output:**

![snapshot](screenshots/12_docker_service_logs.png)

**Observation:**
- No critical errors in recent logs.
- Docker service appears healthy.

### 13. System Log Review

```bash
tail -n 50 /var/log/syslog
```

**Output:**

![snapshot](screenshots/13_system_log_review.png)

**Observation:**
- No kernel-level or Docker-related warnings.
- System operating normally.

---

## Quick Findings

- Docker daemon is running normally.
- CPU and memory utilization are low.
- Disk usage is within acceptable limits.
- Network endpoint is responding.
- Recent logs show no critical errors.
- No evidence of resource exhaustion or service instability.

---

## If This Worsens

### 1. Service Recovery

Check service state and restart if required.

```bash
systemctl status docker
systemctl restart docker
```

**Purpose:**
- Recover from transient daemon issues.
- Validate successful restart.

### 2. Increase Troubleshooting Depth

Collect process-level diagnostics.

```bash
strace -p <PID>
lsof -p <PID>
```

**Purpose:**
- Identify blocked system calls.
- Detect file/socket issues.

### 3. Collect Extended Diagnostics

Capture resource trends and detailed logs.

```bash
docker info
docker ps -a
journalctl -u docker --since "1 hour ago"
```

**Purpose:**
- Gather evidence before escalation.
- Analyze container failures and daemon events.

---

## Conclusion:

A complete health snapshot was collected covering:
- Environment validation
- Filesystem checks
- CPU & memory utilization
- Disk & IO status
- Network connectivity
- Service log analysis

Current status: Docker service is healthy and operational.

---

## 👉 Takeaway:

A strong troubleshooting flow usually follows:
1. Confirm service status
2. Check CPU/Memory 
3. Check Disk/IO 
4. Check Network connectivity 
5. Review Logs 
6. Correlate findings 
7. Mitigate
8. Collect deeper diagnostics

This sequence mirrors how experienced DevOps and SRE engineers approach production incidents under time pressure.