# Laborator Linux — Curs Interactiv

Script Bash interactiv pentru exersarea comenzilor Linux, bazat pe cursul **InfoAcademy Linux** (Capitolele 3, 4, 5, 6, 7, 8, 12, 13).

**Student:** Iacob Costel | Anul I ID | Grupa 106

---

## Rulare

```bash
bash linux-curs-interactiv.sh
```

> Recomandat: WSL (Windows Subsystem for Linux) sau orice terminal Linux/macOS cu Bash 4+.

---

## Capitole acoperite

| # | Capitol | Subiecte |
|---|---------|---------|
| 3 | Sistemul de Fisiere | navigare, permisiuni, arhivare |
| 4 | Utilizatori si Permisiuni | useradd, passwd, grupuri |
| 5 | Procese si Semnale | ps, kill, bg/fg, systemd |
| 6 | Shell Scripting | variabile, bucle, functii, pipe |
| 7 | Administrarea Software-ului | apt, dpkg, hardware |
| 8 | Configurarea Retelei | ip, ping, DNS, porturi |
| 12 | Serverul E-mail | Postfix, SMTP, IMAP |
| 13 | Serverul NTP | chrony, timedatectl |

---

## Cum functioneaza

Navigati prin meniuri cu tastele numerice. In fiecare sectiune sunt afisate explicatiile teoretice si o lista de comenzi pe care le puteti rula individual:

```
  ▸ Alege o comanda de rulat:

    1.  ps aux --sort=-%cpu | head -12
    2.  pstree -p | head -20

    a.  Ruleaza toate comenzile
    c.  Scrie o comanda proprie
    0.  Inapoi

  Alegeti: _
```

Comanda selectata ruleaza in terminal si afiseaza rezultatul incadrat:

```
  ┌── $ ps aux --sort=-%cpu | head -12
  │
  │   USER    PID  %CPU ...
  │
  └── exit code: 0
```
