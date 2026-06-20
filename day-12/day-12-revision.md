# Day 12 – Breather & Revision (Days 01–11)

**Goal:** Review and reinforce the Linux fundamentals learned in Days 01–11 before moving forward and identify areas requiring more practice.

## 1. Mindset & Learning Plan Review

**Original Goal:**

- Build strong Linux fundamentals for DevOps.
- Become comfortable working in Linux servers.
- Improve troubleshooting skills before moving into advanced DevOps tools.

**Updates:**

- Comfortable navigating Linux filesystem.
- Better understanding of process and service management.
- Improved confidence with file permissions and ownership.
- Need more hands-on practice with real time log review and service troubleshooting.

**Next focus:**

- Need to focus more on troubleshooting scenarios.
- Networking
- Shell scripting

---

## 2. Processes & Services Review

**Command 1**

```bash
ps aux
```

**Observation:**

- Displayed all running processes.
- Identified system processes and user processes.
- Useful for checking resource usage and troubleshooting.

**Command 2**

```bash
systemctl status ssh
```

**Observation:**

- Verified SSH service was active and running.
- Checked service uptime and process ID.
- Useful for validating service health.

**Command 3**

```bash
journalctl -u ssh -n 20
```

**Observation:**

- Displayed recent SSH service logs.
- Helpful for debugging service-related issues.

---

## 3. File Operations Practice

**Create and Append Content**

```bash
echo "Day12 Practice" >> notes.txt
```

**Verified using:**

```bash
cat notes.txt
```

**Change Permissions**

```bash
chmod 644 notes.txt
```

**Verified using:**

```bash
ls -l notes.txt
```

**Copy File**

```bash
cp notes.txt backup_notes.txt
```

Verified both files exist.

---

## 4. Incident Cheat Sheet

**Top 5 commands I would use during an incident:**

```bash
ps aux
```

**Purpose:** Check running processes.


```bash
systemctl status <service-name>
```

**Purpose:** Verify service health.


```bash
journalctl -u <service-name>
```

**Purpose:** Review service logs.


```bash
df -h
```

**Purpose:** Check disk usage.


```bash
ls -lah
```

**Purpose:** View files, permissions, ownership, and hidden files.

---

## 5. User & Group Verification

**Create User**

```bash
sudo useradd devopsuser
```

**Verify:**

```bash
id devopsuser
```

**Output confirmed:**

- UID
- GID
- Group membership

**Change Ownership**

```
sudo chown devopsuser:devopsuser notes.txt
```

**Verify:**

```
ls -l notes.txt
```

Ownership updated successfully.

---

## Mini Self-Check

**1. Which 3 commands save you the most time right now, and why?**

- `ls -lah` → Quickly shows files, permissions, ownership, and hidden files.

- `ps aux` → Provides visibility into running processes.

- `systemctl status` → Instantly checks whether a service is healthy or failing.

- `journalctl -u` → Fast troubleshooting using logs.

**2. How do you check if a service is healthy?**

- `systemctl status <service-name>`  → Check if the service is active and running.

- `journalctl -u <service-name> -n 50`  → View the latest logs for errors or warnings.

- `ps aux | grep <process-name>`  → Check if the specific process regarding that service is running.

**3. How do you safely change ownership and permissions without breaking access?**

**Example:**

```bash
sudo chown devopsuser:devopsuser app.log
sudo chmod 644 app.log
```

**Verification:**

```
ls -l app.log
```

Always verify ownership and permissions after making changes.

**4. What will you focus on improving in the next 3 days?**

- Improve Linux troubleshooting skills.
- Service log analysis using journalctl.
- Faster command-line navigation.
- Real-world server administration practice.

---

## Key Takeaways

- Linux troubleshooting always starts with process, service and logs.
- Permissions must be verified after every change.
- Understanding ownership prevents many access issues.
- Process visibility is essential for debugging.
- Speed comes from familiarity, not memorization
- Troubleshooting is a step-by-step process, not guessing