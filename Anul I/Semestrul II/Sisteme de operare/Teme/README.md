# Linux Lab — Interactive Course

An interactive Bash script for practising Linux commands, based on the **InfoAcademy Linux** course (chapters 3, 4, 5, 6, 7, 8, 12, 13).

**Student:** Iacob Costel | Year I ID | Group 106

---

## Running it

```bash
bash linux-curs-interactiv.sh
```

> Recommended: WSL (Windows Subsystem for Linux), or any Linux/macOS terminal with Bash 4+.

---

## Chapters covered

| # | Chapter | Topics |
|---|---------|--------|
| 3 | The Filesystem | navigation, permissions, archiving |
| 4 | Users and Permissions | useradd, passwd, groups |
| 5 | Processes and Signals | ps, kill, bg/fg, systemd |
| 6 | Shell Scripting | variables, loops, functions, pipes |
| 7 | Software Administration | apt, dpkg, hardware |
| 8 | Network Configuration | ip, ping, DNS, ports |
| 12 | Mail Server | Postfix, SMTP, IMAP |
| 13 | NTP Server | chrony, timedatectl |

---

## How it works

Navigate the menus with the number keys. Each section shows the theory first, then a list of commands you can run individually:

```
  ▸ Choose a command to run:

    1.  ps aux --sort=-%cpu | head -12
    2.  pstree -p | head -20

    a.  Run all commands
    c.  Type your own command
    0.  Back

  Choice: _
```

The selected command runs in your terminal and its output is shown framed, with the exit code:

```
  ┌── $ ps aux --sort=-%cpu | head -12
  │
  │   USER    PID  %CPU ...
  │
  └── exit code: 0
```

> The script's own interface is in Romanian — this README describes it in English.
