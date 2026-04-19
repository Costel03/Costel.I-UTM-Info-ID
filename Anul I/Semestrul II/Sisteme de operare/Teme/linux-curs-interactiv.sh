#!/bin/bash
# ╔══════════════════════════════════════════════════════════════╗
# ║          LABORATOR LINUX - CURS INTERACTIV                  ║
# ║──────────────────────────────────────────────────────────────║
# ║  Student : IACOB COSTEL                                     ║
# ║  Anul I ID | Grupa 106                                      ║
# ║  Bazat pe: InfoAcademy Linux - Cap. 3,4,5,6,7,8,12,13      ║
# ╚══════════════════════════════════════════════════════════════╝

# ── Culori (pentru paginile de teorie si output) ──────────────
R='\033[0;31m'   G='\033[0;32m'   Y='\033[1;33m'
C='\033[0;36m'   B='\033[1;34m'   M='\033[0;35m'
W='\033[1;37m'   BOLD='\033[1m'   DIM='\033[2m'
N='\033[0m'

# ── Verificare whiptail / dialog ──────────────────────────────
if command -v whiptail &>/dev/null; then
    DLG="whiptail"
elif command -v dialog &>/dev/null; then
    DLG="dialog"
else
    echo "Se instaleaza whiptail..."
    sudo apt-get install -y whiptail 2>/dev/null || {
        echo "Instalati manual: sudo apt install whiptail"
        exit 1
    }
    DLG="whiptail"
fi

# ── Cleanup ───────────────────────────────────────────────────
DEMO_DIR="/tmp/.linux_curs_$$"
trap 'rm -rf "$DEMO_DIR" 2>/dev/null' EXIT

# ── Separatoare ───────────────────────────────────────────────
L="══════════════════════════════════════════════════════════════"
S="──────────────────────────────────────────────────────────────"

BT="LABORATOR LINUX  |  IACOB COSTEL  |  Anul I ID  |  Grupa 106"

# ╔════════════════════════════════════════════════════════════╗
# ║  FUNCTII HELPER                                           ║
# ╚════════════════════════════════════════════════════════════╝

wmenu() {
    local title="$1" prompt="$2"; shift 2
    local h w mh
    h=$(tput lines 2>/dev/null || echo 24)
    w=$(tput cols 2>/dev/null || echo 80)
    (( w > 78 )) && w=78
    (( h > 35 )) && h=35
    mh=$(( h - 8 ))
    (( mh < 5 )) && mh=5
    $DLG --backtitle "$BT" --title "$title" --menu "$prompt" \
        "$h" "$w" "$mh" "$@" 3>&1 1>&2 2>&3
}

run_cmd() {
    clear
    echo -e "${C}╔${L}╗${N}"
    printf "${C}║${N} ${Y}\$ ${BOLD}%-60s${N}${C}║${N}\n" "$1"
    echo -e "${C}╚${L}╝${N}"
    echo ""
    eval "$1" 2>&1
    local rc=$?
    echo ""
    [[ $rc -eq 0 ]] && echo -e "  ${G}Exit code: 0${N}" || echo -e "  ${R}Exit code: $rc${N}"
    echo -e "\n  ${DIM}${S}${N}"
    echo -ne "  ${G}ENTER pentru a reveni la meniu...${N} "
    read -r
}

theory() {
    clear
    echo -e "$1"
    echo -e "\n  ${DIM}${S}${N}"
    echo -ne "  ${G}ENTER pentru a reveni la meniu...${N} "
    read -r
}

# ╔════════════════════════════════════════════════════════════╗
# ║  CAPITOLUL 3 — SISTEMUL DE FISIERE                        ║
# ╚════════════════════════════════════════════════════════════╝

cap3_1() {
    while true; do
        local c
        c=$(wmenu " Structura FHS " "Teorie sau ruleaza o comanda:" \
            "T" "[Teorie]  Structura sistemului de fisiere" \
            "1" "ls -la /                  (structura radacinii)" \
            "2" "df -Th                    (sisteme de fisiere montate)" \
            "3" "cat /proc/filesystems     (tipuri suportate de kernel)" \
            "4" "du -sh /home /etc /var    (dimensiunea directoarelor)" \
            "0" "<-- Inapoi") || return
        case $c in
            T)  theory "$(echo -e "  ${W}${BOLD}Structura Sistemului de Fisiere (FHS)${N}\n"
                echo -e "  ${C}▸${N} Linux: structura ierarhica pornind din '/' (root)"
                echo -e "  ${C}▸${N} Spre deosebire de Windows, nu exista litere de drive (C:, D:)"
                echo -e "  ${C}▸${N} Totul este un fisier: directoare, dispozitive, procese\n"
                printf "  ${Y}%-14s${N} ${DIM}%s${N}\n" "/home" "directoarele utilizatorilor"
                printf "  ${Y}%-14s${N} ${DIM}%s${N}\n" "/etc" "fisiere de configurare"
                printf "  ${Y}%-14s${N} ${DIM}%s${N}\n" "/var" "date variabile (loguri, spool)"
                printf "  ${Y}%-14s${N} ${DIM}%s${N}\n" "/tmp" "fisiere temporare"
                printf "  ${Y}%-14s${N} ${DIM}%s${N}\n" "/bin" "comenzi de baza (ls, cp, mv)"
                printf "  ${Y}%-14s${N} ${DIM}%s${N}\n" "/usr" "software instalat"
                printf "  ${Y}%-14s${N} ${DIM}%s${N}\n" "/proc" "info procese/kernel (virtual)"
                printf "  ${Y}%-14s${N} ${DIM}%s${N}\n" "/dev" "dispozitive (HDD, USB)"
                printf "  ${Y}%-14s${N} ${DIM}%s${N}\n" "/boot" "kernel si boot loader")" ;;
            1) run_cmd "ls -la / --color=auto" ;;
            2) run_cmd "df -Th | head -15" ;;
            3) run_cmd "cat /proc/filesystems" ;;
            4) run_cmd "du -sh /home /etc /var /tmp 2>/dev/null" ;;
            *) return ;;
        esac
    done
}

cap3_2() {
    while true; do
        local c
        c=$(wmenu " Navigare " "Teorie sau ruleaza o comanda:" \
            "T" "[Teorie]  Comenzi de navigare" \
            "1" "pwd                       (directorul curent)" \
            "2" "ls -lah ~                 (fisierele din home)" \
            "3" "ls -lah /etc/ | head -20  (continut /etc)" \
            "4" "ls -lR /var/log | head -30 (recursiv /var/log)" \
            "0" "<-- Inapoi") || return
        case $c in
            T)  theory "$(echo -e "  ${W}${BOLD}Navigare: pwd, ls, cd${N}\n"
                printf "  ${Y}%-20s${N} ${DIM}%s${N}\n" "pwd" "afiseaza calea curenta"
                printf "  ${Y}%-20s${N} ${DIM}%s${N}\n" "ls -l" "lista lunga (permisiuni, marime)"
                printf "  ${Y}%-20s${N} ${DIM}%s${N}\n" "ls -la" "include fisiere ascunse (.)"
                printf "  ${Y}%-20s${N} ${DIM}%s${N}\n" "ls -lh" "marimi human-readable"
                printf "  ${Y}%-20s${N} ${DIM}%s${N}\n" "ls -lR" "recursiv (subdirectoare)"
                printf "  ${Y}%-20s${N} ${DIM}%s${N}\n" "cd ~" "home directory"
                printf "  ${Y}%-20s${N} ${DIM}%s${N}\n" "cd .." "un nivel in sus"
                printf "  ${Y}%-20s${N} ${DIM}%s${N}\n" "cd -" "directorul anterior"
                echo -e "\n  ${G}TIP:${N} ${DIM}TAB = auto-complete la cai de fisiere${N}")" ;;
            1) run_cmd "pwd" ;;
            2) run_cmd "ls -lah ~ | head -20" ;;
            3) run_cmd "ls -lah /etc/ | head -20" ;;
            4) run_cmd "ls -lR /var/log 2>/dev/null | head -30" ;;
            *) return ;;
        esac
    done
}

cap3_3() {
    while true; do
        local c
        c=$(wmenu " Operatii Fisiere " "Teorie sau ruleaza o comanda:" \
            "T" "[Teorie]  touch, mkdir, cp, mv, rm" \
            "1" "Demo: creeaza directoare si fisiere" \
            "2" "Demo: copiaza si listeaza" \
            "3" "Demo: arhiva completa (mkdir+echo+cp+tree)" \
            "4" "cat /etc/hosts               (afiseaza fisier)" \
            "5" "head -5 / tail -5 /etc/passwd" \
            "0" "<-- Inapoi") || return
        case $c in
            T)  theory "$(echo -e "  ${W}${BOLD}Operatii cu Fisiere: touch, mkdir, cp, mv, rm${N}\n"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "touch fisier.txt" "creeaza fisier gol"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "mkdir -p dir1/dir2" "creeaza directoare nested"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "cp sursa dest" "copiaza fisier"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "cp -r dir1/ dir2/" "copiaza director recursiv"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "mv vechi nou" "redenumeste/muta"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "rm fisier" "sterge fisier"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "rm -rf director/" "sterge director recursiv"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "cat fisier" "afiseaza continut"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "head -N / tail -N" "primele/ultimele N linii"
                echo -e "\n  ${R}ATENTIE:${N} rm -rf este ireversibil! Verificati calea.")" ;;
            1)  mkdir -p "$DEMO_DIR"
                run_cmd "mkdir -p $DEMO_DIR/proiect/src $DEMO_DIR/proiect/docs && touch $DEMO_DIR/proiect/src/main.py && echo 'Salut Linux!' > $DEMO_DIR/proiect/readme.txt && ls -laR $DEMO_DIR/proiect/" ;;
            2)  mkdir -p "$DEMO_DIR/proiect" && echo "test" > "$DEMO_DIR/proiect/fisier.txt"
                run_cmd "cp $DEMO_DIR/proiect/fisier.txt $DEMO_DIR/proiect/copie.txt && ls -la $DEMO_DIR/proiect/" ;;
            3)  mkdir -p "$DEMO_DIR"
                run_cmd "mkdir -p $DEMO_DIR/test/{src,docs,build} && echo 'Hello' > $DEMO_DIR/test/src/main.c && echo 'Readme' > $DEMO_DIR/test/docs/README.md && tree $DEMO_DIR/test 2>/dev/null || find $DEMO_DIR/test -type f && rm -rf $DEMO_DIR/test && echo 'Curatat!'" ;;
            4) run_cmd "cat /etc/hosts" ;;
            5) run_cmd "echo '--- Primele 5 linii:' && head -5 /etc/passwd && echo '' && echo '--- Ultimele 5 linii:' && tail -5 /etc/passwd" ;;
            *) return ;;
        esac
    done
}

cap3_4() {
    while true; do
        local c
        c=$(wmenu " Permisiuni " "Teorie sau ruleaza o comanda:" \
            "T" "[Teorie]  chmod, chown, rwx, octal" \
            "1" "ls -la /etc/passwd /etc/shadow" \
            "2" "stat /etc/hosts              (detalii permisiuni)" \
            "3" "umask                        (masca implicita)" \
            "4" "Demo: chmod pe un script de test" \
            "0" "<-- Inapoi") || return
        case $c in
            T)  theory "$(echo -e "  ${W}${BOLD}Permisiuni: chmod, chown (rwx / octal)${N}\n"
                echo -e "  ${C}▸${N} Fiecare fisier: 3 seturi permisiuni — proprietar(u), grup(g), altii(o)"
                echo -e "  ${C}▸${N} Drepturi: ${Y}r${N}=citire(4), ${Y}w${N}=scriere(2), ${Y}x${N}=executie(1)\n"
                echo -e "  Combinatii octal frecvente:"
                printf "  ${Y}%-20s${N} ${DIM}%s${N}\n" "755 = rwxr-xr-x" "executabil/script"
                printf "  ${Y}%-20s${N} ${DIM}%s${N}\n" "644 = rw-r--r--" "fisier text obisnuit"
                printf "  ${Y}%-20s${N} ${DIM}%s${N}\n" "700 = rwx------" "acces doar proprietar"
                printf "  ${Y}%-20s${N} ${DIM}%s${N}\n" "600 = rw-------" "fisier privat (chei SSH)"
                echo ""
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "chmod 755 script.sh" "seteaza permisiuni octal"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "chmod u+x script.sh" "adauga executie proprietar"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "chown user:grup fisier" "schimba proprietar")" ;;
            1) run_cmd "ls -la /etc/passwd /etc/shadow 2>/dev/null || ls -la /etc/passwd" ;;
            2) run_cmd "stat /etc/hosts" ;;
            3) run_cmd "umask && echo 'Masca implicita (valoarea se scade din 666/777)'" ;;
            4)  mkdir -p "$DEMO_DIR"
                echo '#!/bin/bash' > "$DEMO_DIR/test.sh"
                echo 'echo "Script executat cu succes!"' >> "$DEMO_DIR/test.sh"
                run_cmd "echo '--- Inainte:' && ls -l $DEMO_DIR/test.sh && chmod 755 $DEMO_DIR/test.sh && echo '--- Dupa chmod 755:' && ls -l $DEMO_DIR/test.sh && echo '--- Rulam:' && $DEMO_DIR/test.sh" ;;
            *) return ;;
        esac
    done
}

cap3_5() {
    while true; do
        local c
        c=$(wmenu " Cautare " "Teorie sau ruleaza o comanda:" \
            "T" "[Teorie]  find, grep, which" \
            "1" "find /etc -name '*.conf'     (cauta .conf)" \
            "2" "which bash python3 ls        (locatie executabile)" \
            "3" "grep 'bash' /etc/passwd      (cauta text)" \
            "4" "grep -rv 'nologin' /etc/passwd (fara nologin)" \
            "0" "<-- Inapoi") || return
        case $c in
            T)  theory "$(echo -e "  ${W}${BOLD}Cautare: find, locate, grep, which${N}\n"
                printf "  ${Y}%-30s${N} ${DIM}%s${N}\n" "find /etc -name '*.conf'" "cauta dupa nume"
                printf "  ${Y}%-30s${N} ${DIM}%s${N}\n" "find / -size +100M" "fisiere mari"
                printf "  ${Y}%-30s${N} ${DIM}%s${N}\n" "find . -mtime -1" "modificate azi"
                printf "  ${Y}%-30s${N} ${DIM}%s${N}\n" "grep 'text' fisier" "cauta text in fisier"
                printf "  ${Y}%-30s${N} ${DIM}%s${N}\n" "grep -r 'text' /etc/" "recursiv in director"
                printf "  ${Y}%-30s${N} ${DIM}%s${N}\n" "grep -i 'text' fisier" "case-insensitive"
                printf "  ${Y}%-30s${N} ${DIM}%s${N}\n" "which comanda" "calea executabilului")" ;;
            1) run_cmd "find /etc -maxdepth 1 -name '*.conf' 2>/dev/null | head -15" ;;
            2) run_cmd "which bash python3 ls 2>/dev/null" ;;
            3) run_cmd "grep 'bash' /etc/passwd" ;;
            4) run_cmd "grep -v 'nologin' /etc/passwd | head -10" ;;
            *) return ;;
        esac
    done
}

cap3_6() {
    while true; do
        local c
        c=$(wmenu " Arhivare " "Teorie sau ruleaza o comanda:" \
            "T" "[Teorie]  tar, gzip, zip" \
            "1" "Demo: creeaza arhiva tar.gz" \
            "2" "Demo: listeaza continut arhiva" \
            "3" "file /bin/ls               (detecteaza tip fisier)" \
            "0" "<-- Inapoi") || return
        case $c in
            T)  theory "$(echo -e "  ${W}${BOLD}Arhivare: tar, gzip, zip${N}\n"
                echo -e "  ${C}▸${N} tar grupeaza fisiere; gzip/bzip2/xz le comprima\n"
                printf "  ${Y}%-30s${N} ${DIM}%s${N}\n" "tar -czvf arhiva.tar.gz dir/" "creeaza arhiva gzip"
                printf "  ${Y}%-30s${N} ${DIM}%s${N}\n" "tar -xzvf arhiva.tar.gz" "dezarhiveaza"
                printf "  ${Y}%-30s${N} ${DIM}%s${N}\n" "tar -tzvf arhiva.tar.gz" "listeaza continut"
                printf "  ${Y}%-30s${N} ${DIM}%s${N}\n" "gzip fisier" "comprima"
                printf "  ${Y}%-30s${N} ${DIM}%s${N}\n" "gunzip fisier.gz" "decomprima"
                printf "  ${Y}%-30s${N} ${DIM}%s${N}\n" "zip -r arhiva.zip dir/" "format zip"
                echo -e "\n  ${G}TIP:${N} ${DIM}c=create, x=extract, t=list | z=gzip j=bzip2 | v=verbose f=file${N}")" ;;
            1)  mkdir -p "$DEMO_DIR"
                run_cmd "tar -czvf $DEMO_DIR/demo.tar.gz /etc/hosts /etc/hostname 2>/dev/null && ls -lh $DEMO_DIR/demo.tar.gz" ;;
            2)  [[ -f "$DEMO_DIR/demo.tar.gz" ]] || { mkdir -p "$DEMO_DIR"; tar -czf "$DEMO_DIR/demo.tar.gz" /etc/hosts 2>/dev/null; }
                run_cmd "tar -tzvf $DEMO_DIR/demo.tar.gz" ;;
            3) run_cmd "file /bin/ls /etc/hosts /usr/bin/python3 2>/dev/null" ;;
            *) return ;;
        esac
    done
}

cap3_menu() {
    while true; do
        local c
        c=$(wmenu " Sistemul de Fisiere " "Selectati un sub-capitol:" \
            "1" "Structura FHS (/, /home, /etc, /var)" \
            "2" "Navigare (pwd, ls, cd)" \
            "3" "Operatii fisiere (touch, mkdir, cp, mv, rm)" \
            "4" "Permisiuni (chmod, chown, octal)" \
            "5" "Cautare (find, grep, which)" \
            "6" "Arhivare (tar, gzip, zip)" \
            "0" "<-- Meniu Principal") || return
        case $c in
            1)cap3_1;; 2)cap3_2;; 3)cap3_3;; 4)cap3_4;; 5)cap3_5;; 6)cap3_6;; *)return;;
        esac
    done
}

# ╔════════════════════════════════════════════════════════════╗
# ║  CAPITOLUL 4 — UTILIZATORI SI PERMISIUNI                  ║
# ╚════════════════════════════════════════════════════════════╝

cap4_1() {
    while true; do
        local c
        c=$(wmenu " Informatii Utilizatori " "Teorie sau ruleaza o comanda:" \
            "T" "[Teorie]  Despre utilizatori si fisiere" \
            "1" "whoami                      (cine sunt?)" \
            "2" "id                          (UID, GID, grupuri)" \
            "3" "head -5 /etc/passwd         (structura fisierului)" \
            "4" "w                           (utilizatori conectati)" \
            "5" "last | head -10             (istoricul conectarilor)" \
            "0" "<-- Inapoi") || return
        case $c in
            T)  theory "$(echo -e "  ${W}${BOLD}Informatii despre Utilizatori${N}\n"
                echo -e "  ${C}▸${N} Fiecare utilizator: UID unic + grup primar (GID)"
                echo -e "  ${C}▸${N} root = UID 0, utilizatori normali UID >= 1000\n"
                echo -e "  Fisiere importante:"
                printf "  ${Y}%-18s${N} ${DIM}%s${N}\n" "/etc/passwd" "user:x:UID:GID:Info:Home:Shell"
                printf "  ${Y}%-18s${N} ${DIM}%s${N}\n" "/etc/shadow" "parole criptate (doar root)"
                printf "  ${Y}%-18s${N} ${DIM}%s${N}\n" "/etc/group" "definitii grupuri"
                echo ""
                printf "  ${Y}%-18s${N} ${DIM}%s${N}\n" "whoami" "utilizatorul curent"
                printf "  ${Y}%-18s${N} ${DIM}%s${N}\n" "id" "UID, GID, grupuri"
                printf "  ${Y}%-18s${N} ${DIM}%s${N}\n" "who / w" "utilizatori conectati"
                printf "  ${Y}%-18s${N} ${DIM}%s${N}\n" "last" "istoricul conectarilor")" ;;
            1) run_cmd "whoami" ;;
            2) run_cmd "id" ;;
            3) run_cmd "head -5 /etc/passwd" ;;
            4) run_cmd "w 2>/dev/null || who" ;;
            5) run_cmd "last | head -10 2>/dev/null || echo 'Comanda last indisponibila'" ;;
            *) return ;;
        esac
    done
}

cap4_2() {
    while true; do
        local c
        c=$(wmenu " Creare Utilizatori " "Teorie sau ruleaza o comanda:" \
            "T" "[Teorie]  useradd, adduser, passwd" \
            "1" "Utilizatori cu shell interactiv" \
            "2" "wc -l /etc/passwd           (cati utilizatori)" \
            "3" "cat /etc/shells             (shell-uri disponibile)" \
            "0" "<-- Inapoi") || return
        case $c in
            T)  theory "$(echo -e "  ${W}${BOLD}Crearea Utilizatorilor${N}\n"
                printf "  ${Y}%-30s${N} ${DIM}%s${N}\n" "useradd -m user" "creeaza user cu home dir"
                printf "  ${Y}%-30s${N} ${DIM}%s${N}\n" "useradd -m -s /bin/bash u" "cu shell specificat"
                printf "  ${Y}%-30s${N} ${DIM}%s${N}\n" "useradd -m -G sudo,g1 u" "cu grupuri suplimentare"
                printf "  ${Y}%-30s${N} ${DIM}%s${N}\n" "adduser user" "mod interactiv (recomandat)"
                printf "  ${Y}%-30s${N} ${DIM}%s${N}\n" "passwd user" "seteaza/schimba parola"
                echo -e "\n  ${R}ATENTIE:${N} Comenzile de creare necesita ${BOLD}sudo${N}!")" ;;
            1) run_cmd "grep -v 'nologin\|false' /etc/passwd | cut -d: -f1,3,6,7" ;;
            2) run_cmd "wc -l /etc/passwd && echo 'intrari in /etc/passwd'" ;;
            3) run_cmd "cat /etc/shells" ;;
            *) return ;;
        esac
    done
}

cap4_3() {
    while true; do
        local c
        c=$(wmenu " Modificare Utilizatori " "Teorie sau ruleaza o comanda:" \
            "T" "[Teorie]  usermod, chage" \
            "1" "chage -l \$(whoami)         (info expirare)" \
            "2" "grep \$(whoami) /etc/passwd (linia ta)" \
            "0" "<-- Inapoi") || return
        case $c in
            T)  theory "$(echo -e "  ${W}${BOLD}Modificarea Utilizatorilor (usermod)${N}\n"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "usermod -aG sudo user" "adauga in grup (APPEND!)"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "usermod -s /bin/zsh user" "schimba shell"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "usermod -L user" "Lock (blocheaza contul)"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "usermod -U user" "Unlock (deblocheaza)"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "chage -l user" "info expirare parola"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "chage -M 90 user" "parola expira la 90 zile"
                echo -e "\n  ${R}ATENTIE:${N} Fara ${BOLD}-a${N} la usermod -G, se suprascriu grupurile!")" ;;
            1) run_cmd "chage -l $(whoami) 2>/dev/null || echo 'chage necesita root'" ;;
            2) run_cmd "grep ^$(whoami) /etc/passwd" ;;
            *) return ;;
        esac
    done
}

cap4_4() {
    while true; do
        local c
        c=$(wmenu " Stergere Utilizatori " "Teorie sau ruleaza o comanda:" \
            "T" "[Teorie]  userdel" \
            "1" "Fisiere fara proprietar in /tmp" \
            "0" "<-- Inapoi") || return
        case $c in
            T)  theory "$(echo -e "  ${W}${BOLD}Stergerea Utilizatorilor (userdel)${N}\n"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "userdel user" "sterge (pastreaza /home)"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "userdel -r user" "sterge + home directory"
                echo -e "\n  Inainte de stergere verificati:"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "find / -user user" "fisierele utilizatorului"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "pkill -u user" "opriti procesele active")" ;;
            1) run_cmd "find /tmp -maxdepth 2 -nouser 2>/dev/null | head -5 || echo 'Niciun fisier orfan in /tmp'" ;;
            *) return ;;
        esac
    done
}

cap4_5() {
    while true; do
        local c
        c=$(wmenu " Gestionarea Grupurilor " "Teorie sau ruleaza o comanda:" \
            "T" "[Teorie]  groupadd, groupdel, groups" \
            "1" "groups                        (grupurile mele)" \
            "2" "tail -10 /etc/group           (ultimele grupuri)" \
            "3" "id                            (UID + toate grupurile)" \
            "0" "<-- Inapoi") || return
        case $c in
            T)  theory "$(echo -e "  ${W}${BOLD}Gestionarea Grupurilor${N}\n"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "groups" "grupurile mele"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "groupadd dezvoltatori" "creeaza grup"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "groupmod -n new old" "redenumeste"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "groupdel grup" "sterge"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "usermod -aG grup user" "adauga user la grup")" ;;
            1) run_cmd "groups $(whoami)" ;;
            2) run_cmd "tail -10 /etc/group" ;;
            3) run_cmd "id" ;;
            *) return ;;
        esac
    done
}

cap4_menu() {
    while true; do
        local c
        c=$(wmenu " Utilizatori si Permisiuni " "Selectati un sub-capitol:" \
            "1" "Informatii utilizatori (whoami, id, /etc/passwd)" \
            "2" "Crearea utilizatorilor (useradd, adduser)" \
            "3" "Modificarea utilizatorilor (usermod, chage)" \
            "4" "Stergerea utilizatorilor (userdel)" \
            "5" "Gestionarea grupurilor (groupadd, groupdel)" \
            "0" "<-- Meniu Principal") || return
        case $c in
            1)cap4_1;; 2)cap4_2;; 3)cap4_3;; 4)cap4_4;; 5)cap4_5;; *)return;;
        esac
    done
}

# ╔════════════════════════════════════════════════════════════╗
# ║  CAPITOLUL 5 — PROCESE SI SEMNALE                         ║
# ╚════════════════════════════════════════════════════════════╝

cap5_1() {
    while true; do
        local c
        c=$(wmenu " Monitorizarea Proceselor " "Teorie sau ruleaza o comanda:" \
            "T" "[Teorie]  ps, top, pstree" \
            "1" "ps aux --sort=-%cpu | head    (top CPU)" \
            "2" "ps aux --sort=-%mem | head    (top RAM)" \
            "3" "pstree -p | head -25          (arbore procese)" \
            "4" "cat /proc/cpuinfo | head -20  (info CPU)" \
            "0" "<-- Inapoi") || return
        case $c in
            T)  theory "$(echo -e "  ${W}${BOLD}Afisarea si Monitorizarea Proceselor${N}\n"
                echo -e "  ${C}▸${N} Un proces = un program in executie (PID unic)"
                echo -e "  ${C}▸${N} PID 1 (systemd/init) = parintele tuturor proceselor\n"
                printf "  ${Y}%-20s${N} ${DIM}%s${N}\n" "ps aux" "toate procesele (format BSD)"
                printf "  ${Y}%-20s${N} ${DIM}%s${N}\n" "ps -ef" "toate procesele (format UNIX)"
                printf "  ${Y}%-20s${N} ${DIM}%s${N}\n" "top" "monitor interactiv (q=iesire)"
                printf "  ${Y}%-20s${N} ${DIM}%s${N}\n" "htop" "versiune imbunatatita"
                printf "  ${Y}%-20s${N} ${DIM}%s${N}\n" "pstree" "arbore de procese"
                echo -e "\n  Coloane ps aux: USER PID %CPU %MEM VSZ RSS STAT COMMAND"
                echo -e "  STAT: ${Y}R${N}=running ${Y}S${N}=sleeping ${Y}Z${N}=zombie ${Y}T${N}=stopped ${Y}D${N}=I/O")" ;;
            1) run_cmd "ps aux --sort=-%cpu | head -12" ;;
            2) run_cmd "ps aux --sort=-%mem | head -12" ;;
            3) run_cmd "pstree -p | head -25" ;;
            4) run_cmd "cat /proc/cpuinfo | head -20" ;;
            *) return ;;
        esac
    done
}

cap5_2() {
    while true; do
        local c
        c=$(wmenu " Background / Foreground " "Teorie sau ruleaza o comanda:" \
            "T" "[Teorie]  bg, fg, jobs, &, nohup" \
            "1" "Demo: start bg + jobs + kill" \
            "0" "<-- Inapoi") || return
        case $c in
            T)  theory "$(echo -e "  ${W}${BOLD}Background / Foreground / Jobs${N}\n"
                printf "  ${Y}%-20s${N} ${DIM}%s${N}\n" "comanda &" "porneste in background"
                printf "  ${Y}%-20s${N} ${DIM}%s${N}\n" "Ctrl+Z" "suspenda procesul curent"
                printf "  ${Y}%-20s${N} ${DIM}%s${N}\n" "bg / bg %N" "continua in background"
                printf "  ${Y}%-20s${N} ${DIM}%s${N}\n" "fg / fg %N" "aduce in foreground"
                printf "  ${Y}%-20s${N} ${DIM}%s${N}\n" "jobs -l" "listeaza job-uri"
                printf "  ${Y}%-20s${N} ${DIM}%s${N}\n" "nohup cmd &" "supravietuieste logout"
                printf "  ${Y}%-20s${N} ${DIM}%s${N}\n" "disown" "detaseaza de terminal")" ;;
            1) run_cmd "sleep 60 & echo \"PID: \$!\" && jobs -l && kill %1 2>/dev/null && echo 'Proces oprit.'" ;;
            *) return ;;
        esac
    done
}

cap5_3() {
    while true; do
        local c
        c=$(wmenu " Semnale " "Teorie sau ruleaza o comanda:" \
            "T" "[Teorie]  kill, killall, pkill, semnale" \
            "1" "kill -l                       (lista semnale)" \
            "2" "Demo: porneste + kill proces" \
            "0" "<-- Inapoi") || return
        case $c in
            T)  theory "$(echo -e "  ${W}${BOLD}Semnale: kill, killall, pkill${N}\n"
                echo -e "  Semnalele controleaza procesele:\n"
                printf "  ${Y}%-18s${N} ${DIM}%s${N}\n" "SIGHUP  (1)" "reload config / terminare la logout"
                printf "  ${Y}%-18s${N} ${DIM}%s${N}\n" "SIGINT  (2)" "intrerupe (Ctrl+C)"
                printf "  ${Y}%-18s${N} ${DIM}%s${N}\n" "SIGKILL (9)" "fortat — nu poate fi ignorat!"
                printf "  ${Y}%-18s${N} ${DIM}%s${N}\n" "SIGTERM (15)" "terminare eleganta (default)"
                printf "  ${Y}%-18s${N} ${DIM}%s${N}\n" "SIGSTOP (19)" "suspenda — nu poate fi ignorat"
                echo ""
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "kill PID" "trimite SIGTERM"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "kill -9 PID" "SIGKILL (fortat)"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "killall firefox" "opreste dupa nume"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "pkill -u user" "opreste dupa utilizator")" ;;
            1) run_cmd "kill -l" ;;
            2) run_cmd "sleep 120 & PID=\$!; echo \"Proces pornit PID=\$PID\"; kill \$PID; wait \$PID 2>/dev/null; echo \"Proces terminat.\"" ;;
            *) return ;;
        esac
    done
}

cap5_4() {
    while true; do
        local c
        c=$(wmenu " Prioritati " "Teorie sau ruleaza o comanda:" \
            "T" "[Teorie]  nice, renice" \
            "1" "ps -eo pid,ni,user,comm      (prioritati procese)" \
            "0" "<-- Inapoi") || return
        case $c in
            T)  theory "$(echo -e "  ${W}${BOLD}Prioritati: nice, renice${N}\n"
                echo -e "  ${C}▸${N} Nice: -20 (cea mai mare) la +19 (cea mai mica)"
                echo -e "  ${C}▸${N} Doar root poate seta valori negative\n"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "nice -n 10 comanda" "prioritate redusa"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "nice -n -5 comanda" "prioritate ridicata (root)"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "renice 5 -p PID" "modifica proces activ")" ;;
            1) run_cmd "ps -eo pid,ni,user,comm --sort=-ni | head -15" ;;
            *) return ;;
        esac
    done
}

cap5_5() {
    while true; do
        local c
        c=$(wmenu " Servicii Systemd " "Teorie sau ruleaza o comanda:" \
            "T" "[Teorie]  systemctl, journalctl" \
            "1" "systemctl list-units --type=service --state=running" \
            "2" "systemctl status ssh          (starea SSH)" \
            "0" "<-- Inapoi") || return
        case $c in
            T)  theory "$(echo -e "  ${W}${BOLD}Servicii si Systemd${N}\n"
                echo -e "  ${C}▸${N} Ubuntu foloseste systemd pentru gestionarea serviciilor\n"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "systemctl status serv" "starea serviciului"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "systemctl start serv" "porneste"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "systemctl stop serv" "opreste"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "systemctl restart serv" "reporneste"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "systemctl enable serv" "pornire la boot"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "journalctl -u serv -f" "loguri live")" ;;
            1) run_cmd "systemctl list-units --type=service --state=running 2>/dev/null | head -20 || echo 'systemctl indisponibil'" ;;
            2) run_cmd "systemctl status ssh 2>/dev/null || echo 'SSH nu ruleaza sau systemctl indisponibil'" ;;
            *) return ;;
        esac
    done
}

cap5_menu() {
    while true; do
        local c
        c=$(wmenu " Procese si Semnale " "Selectati un sub-capitol:" \
            "1" "Monitorizarea proceselor (ps, top, pstree)" \
            "2" "Background / Foreground (bg, fg, jobs)" \
            "3" "Semnale (kill, killall, pkill)" \
            "4" "Prioritati (nice, renice)" \
            "5" "Servicii Systemd (systemctl)" \
            "0" "<-- Meniu Principal") || return
        case $c in
            1)cap5_1;; 2)cap5_2;; 3)cap5_3;; 4)cap5_4;; 5)cap5_5;; *)return;;
        esac
    done
}

# ╔════════════════════════════════════════════════════════════╗
# ║  CAPITOLUL 6 — SHELL SCRIPTING                            ║
# ╚════════════════════════════════════════════════════════════╝

cap6_1() {
    while true; do
        local c
        c=$(wmenu " Variabile " "Teorie sau ruleaza o comanda:" \
            "T" "[Teorie]  Variabile si mediu" \
            "1" "echo HOME, USER, SHELL       (variabile mediu)" \
            "2" "echo PATH                    (cai executabile)" \
            "3" "Demo: calcul aritmetic        (\$((...)))" \
            "4" "env | head -15               (toate var. mediu)" \
            "0" "<-- Inapoi") || return
        case $c in
            T)  theory "$(echo -e "  ${W}${BOLD}Variabile${N}\n"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "NUME='Costel'" "atribuire (fara spatii la =)"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "echo \$NUME" "afiseaza valoarea"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "echo \"Salut \$NUME\"" "expansiune (ghilimele duble)"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "echo 'Salut \$NUME'" "literal (ghilimele simple)"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "SUMA=\$((3+4))" "calcul aritmetic"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "DATA=\$(date)" "captura output comanda"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "export VAR='val'" "accesibila in subprocese"
                echo -e "\n  Variabile predefinite:"
                printf "  ${Y}%-12s${N} ${DIM}%s${N}\n" "\$HOME" "directorul home"
                printf "  ${Y}%-12s${N} ${DIM}%s${N}\n" "\$PATH" "cai de cautare"
                printf "  ${Y}%-12s${N} ${DIM}%s${N}\n" "\$USER" "utilizator curent"
                printf "  ${Y}%-12s${N} ${DIM}%s${N}\n" "\$SHELL" "shell-ul curent")" ;;
            1) run_cmd "echo \"HOME=\$HOME\" && echo \"USER=\$USER\" && echo \"SHELL=\$SHELL\" && echo \"PWD=\$PWD\"" ;;
            2) run_cmd "echo \$PATH | tr ':' '\n'" ;;
            3) run_cmd "echo \"15 * 7 + 3 = \$((15 * 7 + 3))\" && echo \"2^10 = \$((2**10))\" && echo \"100 / 7 = \$((100/7)) rest \$((100%7))\"" ;;
            4) run_cmd "env | sort | head -15" ;;
            *) return ;;
        esac
    done
}

cap6_2() {
    while true; do
        local c
        c=$(wmenu " Citire Date " "Teorie sau ruleaza o comanda:" \
            "T" "[Teorie]  read, argumente" \
            "1" "Demo: citeste numele tau (read)" \
            "2" "echo \$0 \$\$ \$USER           (var. speciale)" \
            "0" "<-- Inapoi") || return
        case $c in
            T)  theory "$(echo -e "  ${W}${BOLD}Citirea Datelor: read si Argumente${N}\n"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "read VAR" "citeste o linie"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "read -p 'Msg: ' VAR" "cu prompt"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "read -s VAR" "silent (parole)"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "read -t 5 VAR" "timeout 5 secunde"
                echo -e "\n  Variabile speciale (in scripturi):"
                printf "  ${Y}%-12s${N} ${DIM}%s${N}\n" "\$0" "numele scriptului"
                printf "  ${Y}%-12s${N} ${DIM}%s${N}\n" "\$1 \$2" "argumente pozitionale"
                printf "  ${Y}%-12s${N} ${DIM}%s${N}\n" "\$#" "numarul de argumente"
                printf "  ${Y}%-12s${N} ${DIM}%s${N}\n" "\$@" "toate argumentele"
                printf "  ${Y}%-12s${N} ${DIM}%s${N}\n" "\$?" "exit code ultima comanda"
                printf "  ${Y}%-12s${N} ${DIM}%s${N}\n" "\$\$" "PID script curent")" ;;
            1)  clear
                echo -e "${C}╔${L}╗${N}"
                echo -e "${C}║${N} ${Y}\$ ${BOLD}read -p 'Numele tau: ' NUME; echo \"Salut, \$NUME!\"${N}       ${C}║${N}"
                echo -e "${C}╚${L}╝${N}"
                echo ""
                read -p "  Numele tau: " DEMO_NUME
                DEMO_NUME=${DEMO_NUME:-Student}
                echo -e "\n  Salut, ${W}${BOLD}${DEMO_NUME}${N}! Bine ai venit in Shell Scripting."
                echo -e "\n  ${DIM}${S}${N}"
                echo -ne "  ${G}ENTER pentru a reveni la meniu...${N} "
                read -r ;;
            2) run_cmd "echo \"Script: \$0\" && echo \"PID: \$\$\" && echo \"User: \$USER\"" ;;
            *) return ;;
        esac
    done
}

cap6_3() {
    while true; do
        local c
        c=$(wmenu " Conditii " "Teorie sau ruleaza o comanda:" \
            "T" "[Teorie]  if, elif, case, operatori" \
            "1" "Demo: verifica varsta (if -ge)" \
            "2" "Demo: exista /etc/hosts? (if -f)" \
            "3" "Demo: sistem APT? (if -d /etc/apt)" \
            "4" "Demo: ce SO ruleaza? (uname)" \
            "0" "<-- Inapoi") || return
        case $c in
            T)  theory "$(echo -e "  ${W}${BOLD}Structuri Conditionale: if / case${N}\n"
                echo -e "  ${Y}if [ conditie ]; then${N}"
                echo -e "  ${Y}    comenzi${N}"
                echo -e "  ${Y}elif [ alta ]; then${N}"
                echo -e "  ${Y}    comenzi${N}"
                echo -e "  ${Y}else${N}"
                echo -e "  ${Y}    comenzi${N}"
                echo -e "  ${Y}fi${N}"
                echo -e "\n  Operatori numerici: ${Y}-eq -ne -lt -le -gt -ge${N}"
                echo -e "  Operatori siruri:   ${Y}= != -z(gol) -n(nevid)${N}"
                echo -e "  Operatori fisiere:  ${Y}-f(fisier) -d(dir) -e(exista) -r -w -x${N}")" ;;
            1) run_cmd "VARSTA=20; if [ \$VARSTA -ge 18 ]; then echo \"Major (\$VARSTA ani)\"; else echo \"Minor\"; fi" ;;
            2) run_cmd "if [ -f /etc/hosts ]; then echo \"/etc/hosts exista (\$(wc -l < /etc/hosts) linii)\"; fi" ;;
            3) run_cmd "if [ -d /etc/apt ]; then echo 'Sistem bazat pe APT (Debian/Ubuntu)'; else echo 'Nu este Debian/Ubuntu'; fi" ;;
            4) run_cmd "[[ \$(uname -s) == 'Linux' ]] && echo \"Sistem: Linux (\$(uname -r))\" || echo 'Alt SO'" ;;
            *) return ;;
        esac
    done
}

cap6_4() {
    while true; do
        local c
        c=$(wmenu " Bucle " "Teorie sau ruleaza o comanda:" \
            "T" "[Teorie]  for, while, until" \
            "1" "Demo: for 1..5 cu timestamp" \
            "2" "Demo: for pe utilizatori /etc/passwd" \
            "3" "Demo: while counter" \
            "4" "Demo: for pe fisiere .conf" \
            "0" "<-- Inapoi") || return
        case $c in
            T)  theory "$(echo -e "  ${W}${BOLD}Bucle: for / while / until${N}\n"
                echo -e "  ${Y}for var in lista; do ... done${N}"
                echo -e "  ${Y}for ((i=0; i<10; i++)); do ... done${N}"
                echo -e "  ${Y}while [ cond ]; do ... done${N}"
                echo -e "  ${Y}until [ cond ]; do ... done${N}"
                echo -e "\n  Controlul buclei:"
                printf "  ${Y}%-12s${N} ${DIM}%s${N}\n" "break" "iese din bucla"
                printf "  ${Y}%-12s${N} ${DIM}%s${N}\n" "continue" "sare la iteratia urmatoare")" ;;
            1) run_cmd "for i in 1 2 3 4 5; do echo \"  Iteratia \$i: \$(date +%H:%M:%S.%N | cut -c1-12)\"; done" ;;
            2) run_cmd "for user in \$(cut -d: -f1 /etc/passwd | head -5); do echo \"  User: \$user\"; done" ;;
            3) run_cmd "C=1; while [ \$C -le 5 ]; do echo \"  While #\$C\"; C=\$((C+1)); done" ;;
            4) run_cmd "for f in /etc/*.conf; do [ -f \"\$f\" ] && echo \"  \$(basename \"\$f\") (\$(wc -l < \"\$f\") linii)\"; done 2>/dev/null | head -8" ;;
            *) return ;;
        esac
    done
}

cap6_5() {
    while true; do
        local c
        c=$(wmenu " Functii " "Teorie sau ruleaza o comanda:" \
            "T" "[Teorie]  Declarare si utilizare functii" \
            "1" "Demo: functie salut()" \
            "2" "Demo: functie patrat()" \
            "3" "Demo: functie info_fisier()" \
            "0" "<-- Inapoi") || return
        case $c in
            T)  theory "$(echo -e "  ${W}${BOLD}Functii${N}\n"
                echo -e "  ${Y}functie() {${N}"
                echo -e "  ${Y}    comenzi${N}"
                echo -e "  ${Y}    return 0${N}"
                echo -e "  ${Y}}${N}"
                echo -e "\n  ${C}▸${N} Argumente: \$1, \$2 ... in interiorul functiei"
                echo -e "  ${C}▸${N} return seteaza \$? (exit code)"
                echo -e "  ${C}▸${N} Variabilele sunt globale (folositi 'local' pt locale)")" ;;
            1) run_cmd "salut() { echo \"Buna, \$1! Ai \$2 ani.\"; }; salut 'Costel' '20'" ;;
            2) run_cmd "patrat() { echo \$((\$1 * \$1)); }; echo \"9 la patrat = \$(patrat 9)\" && echo \"15 la patrat = \$(patrat 15)\"" ;;
            3) run_cmd "info_f() { if [ -f \"\$1\" ]; then echo \"Fisier: \$1\"; echo \"Marime: \$(du -h \"\$1\" | cut -f1)\"; echo \"Linii: \$(wc -l < \"\$1\")\"; else echo \"\$1 nu exista!\"; fi; }; info_f /etc/hosts && echo '' && info_f /etc/inexistent" ;;
            *) return ;;
        esac
    done
}

cap6_6() {
    while true; do
        local c
        c=$(wmenu " Filtre si Pipe " "Teorie sau ruleaza o comanda:" \
            "T" "[Teorie]  grep, sed, awk, sort, cut, pipe" \
            "1" "cut + sort pe /etc/passwd    (extrage campuri)" \
            "2" "ps + awk                     (top procese)" \
            "3" "echo | tr                    (transforma text)" \
            "4" "df + grep + awk              (spatiu disk)" \
            "0" "<-- Inapoi") || return
        case $c in
            T)  theory "$(echo -e "  ${W}${BOLD}Filtre si Pipe: grep, sed, awk, sort, cut${N}\n"
                echo -e "  ${C}▸${N} Pipe (|) redirectioneaza output ca input la urmatoarea\n"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "grep 'text' fisier" "cauta pattern"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "sed 's/vechi/nou/g'" "substitutie text"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "awk -F: '{print \$1}'" "extrage coloane"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "sort / sort -rn" "sorteaza"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "uniq" "elimina duplicate"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "cut -d: -f1,3" "extrage campuri"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "wc -l" "numara linii"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "tr 'a-z' 'A-Z'" "transforma caractere")" ;;
            1) run_cmd "cut -d: -f1,3,7 /etc/passwd | sort -t: -k2 -n | tail -10" ;;
            2) run_cmd "ps aux --sort=-%mem | awk 'NR<=6 {printf \"%-12s %5s %5s %s\n\", \$1, \$3, \$4, \$11}'" ;;
            3) run_cmd "echo 'hello linux world!' | tr 'a-z' 'A-Z'" ;;
            4) run_cmd "df -h | grep -v tmpfs | awk '{printf \"%-20s %s folosit\n\", \$1, \$5}'" ;;
            *) return ;;
        esac
    done
}

cap6_menu() {
    while true; do
        local c
        c=$(wmenu " Shell Scripting " "Selectati un sub-capitol:" \
            "1" "Variabile (declarare, export, \$HOME \$PATH)" \
            "2" "Citire date (read, argumente \$1 \$# \$@)" \
            "3" "Conditii (if, elif, operatori)" \
            "4" "Bucle (for, while, until)" \
            "5" "Functii (declarare, return)" \
            "6" "Filtre si pipe (grep, sed, awk, sort)" \
            "0" "<-- Meniu Principal") || return
        case $c in
            1)cap6_1;; 2)cap6_2;; 3)cap6_3;; 4)cap6_4;; 5)cap6_5;; 6)cap6_6;; *)return;;
        esac
    done
}

# ╔════════════════════════════════════════════════════════════╗
# ║  CAPITOLUL 7 — ADMINISTRAREA SOFTWARE-ULUI                ║
# ╚════════════════════════════════════════════════════════════╝

cap7_1() {
    while true; do
        local c
        c=$(wmenu " Gestiune APT " "Teorie sau ruleaza o comanda:" \
            "T" "[Teorie]  apt, dpkg" \
            "1" "apt list --installed | wc -l  (cate pachete)" \
            "2" "dpkg -l | tail -10           (ultimele pachete)" \
            "3" "apt-cache show curl           (detalii pachet)" \
            "0" "<-- Inapoi") || return
        case $c in
            T)  theory "$(echo -e "  ${W}${BOLD}Gestiunea Pachetelor cu APT${N}\n"
                echo -e "  ${C}▸${N} Ubuntu/Debian: APT (Advanced Package Tool)"
                echo -e "  ${C}▸${N} Pachete .deb din repository-uri online\n"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "apt update" "actualizeaza lista"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "apt upgrade" "actualizeaza pachete"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "apt install pachet" "instaleaza"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "apt remove pachet" "dezinstaleaza"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "apt purge pachet" "dezinstaleaza complet"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "apt autoremove" "sterge dependente orfane"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "apt search cuvant" "cauta pachet"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "dpkg -l" "lista pachete (nivel jos)")" ;;
            1) run_cmd "apt list --installed 2>/dev/null | wc -l | xargs -I{} echo '{} pachete instalate'" ;;
            2) run_cmd "dpkg -l | tail -10" ;;
            3) run_cmd "apt-cache show curl 2>/dev/null | head -15" ;;
            *) return ;;
        esac
    done
}

cap7_2() {
    while true; do
        local c
        c=$(wmenu " Instalare Pachete " "Teorie sau ruleaza o comanda:" \
            "T" "[Teorie]  Flux instalare/dezinstalare" \
            "1" "dpkg -L bash | head -10      (fisierele pachetului)" \
            "2" "which curl wget git           (executabile instalate)" \
            "0" "<-- Inapoi") || return
        case $c in
            T)  theory "$(echo -e "  ${W}${BOLD}Instalare si Dezinstalare Pachete${N}\n"
                echo -e "  Flux tipic:\n"
                echo -e "  ${Y}1.${N} sudo apt update"
                echo -e "  ${Y}2.${N} sudo apt install htop -y"
                echo -e "  ${Y}3.${N} which htop   (verifica)"
                echo -e "\n  Dezinstalare:"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "sudo apt remove htop" "pastreaza config"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "sudo apt purge htop" "sterge totul"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "sudo apt autoremove" "curata dependente")" ;;
            1) run_cmd "dpkg -L bash | head -10" ;;
            2) run_cmd "which curl wget git python3 2>/dev/null || echo 'Unele nu sunt instalate'" ;;
            *) return ;;
        esac
    done
}

cap7_3() {
    while true; do
        local c
        c=$(wmenu " Info Hardware " "Teorie sau ruleaza o comanda:" \
            "T" "[Teorie]  Comenzi hardware" \
            "1" "uname -a                    (kernel, arhitectura)" \
            "2" "lscpu | grep ...            (info CPU)" \
            "3" "free -h                     (RAM si swap)" \
            "4" "df -h                       (spatiu disk)" \
            "5" "lsblk                       (dispozitive stocare)" \
            "6" "uptime                      (timp rulare + load)" \
            "0" "<-- Inapoi") || return
        case $c in
            T)  theory "$(echo -e "  ${W}${BOLD}Informatii Hardware si Sistem${N}\n"
                printf "  ${Y}%-14s${N} ${DIM}%s${N}\n" "lscpu" "procesor (core-uri, arhitectura)"
                printf "  ${Y}%-14s${N} ${DIM}%s${N}\n" "free -h" "memorie RAM si swap"
                printf "  ${Y}%-14s${N} ${DIM}%s${N}\n" "lsblk" "dispozitive stocare"
                printf "  ${Y}%-14s${N} ${DIM}%s${N}\n" "df -h" "spatiu disk"
                printf "  ${Y}%-14s${N} ${DIM}%s${N}\n" "lspci" "dispozitive PCI"
                printf "  ${Y}%-14s${N} ${DIM}%s${N}\n" "lsusb" "dispozitive USB"
                printf "  ${Y}%-14s${N} ${DIM}%s${N}\n" "uname -a" "kernel si arhitectura"
                printf "  ${Y}%-14s${N} ${DIM}%s${N}\n" "uptime" "timp rulare + load average")" ;;
            1) run_cmd "uname -a" ;;
            2) run_cmd "lscpu | grep -E '(Architecture|Model name|CPU\(s\)|Thread|Core|Socket|MHz)'" ;;
            3) run_cmd "free -h" ;;
            4) run_cmd "df -h | grep -v tmpfs | grep -v loop" ;;
            5) run_cmd "lsblk 2>/dev/null | head -15" ;;
            6) run_cmd "uptime" ;;
            *) return ;;
        esac
    done
}

cap7_menu() {
    while true; do
        local c
        c=$(wmenu " Administrarea Software-ului " "Selectati un sub-capitol:" \
            "1" "Gestiunea pachetelor APT" \
            "2" "Instalare si dezinstalare" \
            "3" "Informatii hardware (lscpu, free, df)" \
            "0" "<-- Meniu Principal") || return
        case $c in
            1)cap7_1;; 2)cap7_2;; 3)cap7_3;; *)return;;
        esac
    done
}

# ╔════════════════════════════════════════════════════════════╗
# ║  CAPITOLUL 8 — CONFIGURAREA RETELEI                       ║
# ╚════════════════════════════════════════════════════════════╝

cap8_1() {
    while true; do
        local c
        c=$(wmenu " Interfete de Retea " "Teorie sau ruleaza o comanda:" \
            "T" "[Teorie]  ip addr, ifconfig" \
            "1" "ip -br addr                  (interfete scurt)" \
            "2" "ip addr show | grep inet     (adrese IP)" \
            "3" "ip link show                 (starea interfetelor)" \
            "0" "<-- Inapoi") || return
        case $c in
            T)  theory "$(echo -e "  ${W}${BOLD}Interfete de Retea${N}\n"
                printf "  ${Y}%-20s${N} ${DIM}%s${N}\n" "ip addr" "adresele IP ale interfetelor"
                printf "  ${Y}%-20s${N} ${DIM}%s${N}\n" "ip link" "starea interfetelor (up/down)"
                printf "  ${Y}%-20s${N} ${DIM}%s${N}\n" "ifconfig" "comanda clasica (deprecated)"
                echo -e "\n  Tipuri interfete:"
                printf "  ${Y}%-20s${N} ${DIM}%s${N}\n" "eth0 / enp3s0" "Ethernet cablata"
                printf "  ${Y}%-20s${N} ${DIM}%s${N}\n" "wlan0 / wlp2s0" "WiFi"
                printf "  ${Y}%-20s${N} ${DIM}%s${N}\n" "lo" "loopback (127.0.0.1)"
                echo -e "\n  CIDR: 192.168.1.100/24 = IP + masca (/24 = 255.255.255.0)")" ;;
            1) run_cmd "ip -br addr" ;;
            2) run_cmd "ip addr show | grep -E '(^[0-9]|inet )'" ;;
            3) run_cmd "ip link show" ;;
            *) return ;;
        esac
    done
}

cap8_2() {
    while true; do
        local c
        c=$(wmenu " Conectivitate " "Teorie sau ruleaza o comanda:" \
            "T" "[Teorie]  ping, traceroute" \
            "1" "ping -c 3 8.8.8.8            (Google DNS)" \
            "2" "ping -c 3 google.com          (DNS + ping)" \
            "3" "tracepath 8.8.8.8             (ruta pachete)" \
            "0" "<-- Inapoi") || return
        case $c in
            T)  theory "$(echo -e "  ${W}${BOLD}Testare Conectivitate: ping, traceroute${N}\n"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "ping -c 4 host" "4 pachete ICMP"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "traceroute host" "urmareste ruta"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "tracepath host" "fara root"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "mtr host" "ping + traceroute interactiv")" ;;
            1) run_cmd "ping -c 3 8.8.8.8" ;;
            2) run_cmd "ping -c 3 google.com" ;;
            3) run_cmd "tracepath -m 10 8.8.8.8 2>/dev/null || traceroute -m 10 8.8.8.8 2>/dev/null || echo 'tracepath/traceroute indisponibil'" ;;
            *) return ;;
        esac
    done
}

cap8_3() {
    while true; do
        local c
        c=$(wmenu " Rutare " "Teorie sau ruleaza o comanda:" \
            "T" "[Teorie]  ip route, gateway" \
            "1" "ip route show                (tabela de rutare)" \
            "2" "ip route get 8.8.8.8         (pe ce interfata)" \
            "0" "<-- Inapoi") || return
        case $c in
            T)  theory "$(echo -e "  ${W}${BOLD}Rutare si Gateway${N}\n"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "ip route" "tabela de rutare"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "ip route get 8.8.8.8" "pe ce interfata iese"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "ip route add ... via ..." "adauga ruta"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "ip route del ..." "sterge ruta")" ;;
            1) run_cmd "ip route show" ;;
            2) run_cmd "ip route get 8.8.8.8 2>/dev/null" ;;
            *) return ;;
        esac
    done
}

cap8_4() {
    while true; do
        local c
        c=$(wmenu " Porturi si Servicii " "Teorie sau ruleaza o comanda:" \
            "T" "[Teorie]  ss, netstat, porturi" \
            "1" "ss -tuln                     (porturi deschise)" \
            "2" "ss -tulnp                    (cu procese - root)" \
            "0" "<-- Inapoi") || return
        case $c in
            T)  theory "$(echo -e "  ${W}${BOLD}Porturi si Servicii${N}\n"
                echo -e "  Porturi standard:"
                printf "  ${Y}%-12s${N} ${DIM}%s${N}\n" "22" "SSH"
                printf "  ${Y}%-12s${N} ${DIM}%s${N}\n" "25" "SMTP"
                printf "  ${Y}%-12s${N} ${DIM}%s${N}\n" "53" "DNS"
                printf "  ${Y}%-12s${N} ${DIM}%s${N}\n" "80" "HTTP"
                printf "  ${Y}%-12s${N} ${DIM}%s${N}\n" "443" "HTTPS"
                echo ""
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "ss -tuln" "porturi in ascultare"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "ss -tulnp" "cu procesul asociat"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "netstat -tuln" "varianta clasica")" ;;
            1) run_cmd "ss -tuln" ;;
            2) run_cmd "ss -tulnp 2>/dev/null || echo 'Necesita sudo pentru -p'" ;;
            *) return ;;
        esac
    done
}

cap8_5() {
    while true; do
        local c
        c=$(wmenu " DNS " "Teorie sau ruleaza o comanda:" \
            "T" "[Teorie]  nslookup, dig, /etc/hosts" \
            "1" "cat /etc/resolv.conf         (servere DNS)" \
            "2" "nslookup google.com          (rezolvare DNS)" \
            "3" "cat /etc/hosts               (rezolutie locala)" \
            "0" "<-- Inapoi") || return
        case $c in
            T)  theory "$(echo -e "  ${W}${BOLD}DNS: nslookup, dig, /etc/hosts${N}\n"
                echo -e "  ${C}▸${N} DNS traduce hostname-uri in adrese IP\n"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "nslookup google.com" "interogare DNS"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "dig +short google.com" "doar IP-ul"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "host google.com" "interogare rapida"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "/etc/resolv.conf" "servere DNS configurate"
                printf "  ${Y}%-28s${N} ${DIM}%s${N}\n" "/etc/hosts" "rezolutie locala manuala")" ;;
            1) run_cmd "cat /etc/resolv.conf" ;;
            2) run_cmd "nslookup google.com 2>/dev/null || host google.com 2>/dev/null || echo 'nslookup/host indisponibil'" ;;
            3) run_cmd "cat /etc/hosts" ;;
            *) return ;;
        esac
    done
}

cap8_menu() {
    while true; do
        local c
        c=$(wmenu " Configurarea Retelei " "Selectati un sub-capitol:" \
            "1" "Interfete de retea (ip addr, ifconfig)" \
            "2" "Testare conectivitate (ping, traceroute)" \
            "3" "Rutare si gateway (ip route)" \
            "4" "Porturi si servicii (ss, netstat)" \
            "5" "DNS (nslookup, dig, /etc/hosts)" \
            "0" "<-- Meniu Principal") || return
        case $c in
            1)cap8_1;; 2)cap8_2;; 3)cap8_3;; 4)cap8_4;; 5)cap8_5;; *)return;;
        esac
    done
}

# ╔════════════════════════════════════════════════════════════╗
# ║  CAPITOLUL 12 — SERVERUL E-MAIL                           ║
# ╚════════════════════════════════════════════════════════════╝

cap12_1() {
    while true; do
        local c
        c=$(wmenu " Protocoale E-mail " "Teorie sau ruleaza o comanda:" \
            "T" "[Teorie]  SMTP, IMAP, POP3, MTA/MDA/MUA" \
            "1" "ss -tln | grep :25           (SMTP activ?)" \
            "0" "<-- Inapoi") || return
        case $c in
            T)  theory "$(echo -e "  ${W}${BOLD}Protocoale E-mail${N}\n"
                echo -e "  Fluxul unui email:"
                echo -e "  ${W}[Client]${N} --SMTP--> ${W}[MTA Exp.]${N} --SMTP--> ${W}[MTA Dest.]${N} --IMAP--> ${W}[Client]${N}\n"
                printf "  ${Y}%-20s${N} ${DIM}%s${N}\n" "SMTP (25, 587)" "trimitere email"
                printf "  ${Y}%-20s${N} ${DIM}%s${N}\n" "IMAP (143, 993)" "citire (mesaje pe server)"
                printf "  ${Y}%-20s${N} ${DIM}%s${N}\n" "POP3 (110, 995)" "descarca si sterge"
                echo -e "\n  Componente:"
                printf "  ${Y}%-8s${N} ${DIM}%s${N}\n" "MTA" "Mail Transfer Agent (Postfix, Sendmail)"
                printf "  ${Y}%-8s${N} ${DIM}%s${N}\n" "MDA" "Mail Delivery Agent (Dovecot)"
                printf "  ${Y}%-8s${N} ${DIM}%s${N}\n" "MUA" "Mail User Agent (Thunderbird, mutt)")" ;;
            1) run_cmd "ss -tln | grep ':25 ' && echo 'SMTP activ!' || echo 'Portul 25 nu este deschis (Postfix nu ruleaza)'" ;;
            *) return ;;
        esac
    done
}

cap12_2() {
    while true; do
        local c
        c=$(wmenu " Postfix " "Teorie sau ruleaza o comanda:" \
            "T" "[Teorie]  Configurare Postfix" \
            "1" "which postfix                (instalat?)" \
            "2" "Afiseaza config main.cf" \
            "0" "<-- Inapoi") || return
        case $c in
            T)  theory "$(echo -e "  ${W}${BOLD}Postfix: Instalare si Configurare${N}\n"
                echo -e "  ${C}▸${N} Postfix = cel mai popular MTA Linux\n"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "apt install postfix" "instaleaza"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "/etc/postfix/main.cf" "configurare"
                echo -e "\n  Parametri esentiali main.cf:"
                printf "  ${Y}%-20s${N} ${DIM}%s${N}\n" "myhostname" "FQDN al serverului"
                printf "  ${Y}%-20s${N} ${DIM}%s${N}\n" "mydomain" "domeniul principal"
                printf "  ${Y}%-20s${N} ${DIM}%s${N}\n" "inet_interfaces" "interfete (all)"
                printf "  ${Y}%-20s${N} ${DIM}%s${N}\n" "mydestination" "domenii primite"
                printf "  ${Y}%-20s${N} ${DIM}%s${N}\n" "mynetworks" "retele de incredere"
                echo ""
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "postfix check" "verifica config"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "postfix reload" "reincarca"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "mailq" "coada de email")" ;;
            1) run_cmd "which postfix 2>/dev/null && echo 'Postfix instalat' || echo 'Postfix NU este instalat (sudo apt install postfix)'" ;;
            2) run_cmd "[ -f /etc/postfix/main.cf ] && grep -v '^#' /etc/postfix/main.cf | grep -v '^\$' | head -15 || echo '/etc/postfix/main.cf inexistent'" ;;
            *) return ;;
        esac
    done
}

cap12_3() {
    while true; do
        local c
        c=$(wmenu " Testare Email " "Teorie sau ruleaza o comanda:" \
            "T" "[Teorie]  Testare si monitorizare" \
            "1" "mailq                        (coada de email)" \
            "0" "<-- Inapoi") || return
        case $c in
            T)  theory "$(echo -e "  ${W}${BOLD}Testare si Monitorizare Email${N}\n"
                printf "  ${Y}%-30s${N} ${DIM}%s${N}\n" "echo 'Msg' | mail -s 'Sub' u" "trimite email"
                printf "  ${Y}%-30s${N} ${DIM}%s${N}\n" "mail" "citeste email-uri"
                printf "  ${Y}%-30s${N} ${DIM}%s${N}\n" "tail -f /var/log/mail.log" "loguri live"
                printf "  ${Y}%-30s${N} ${DIM}%s${N}\n" "journalctl -u postfix -f" "loguri systemd"
                printf "  ${Y}%-30s${N} ${DIM}%s${N}\n" "mailq" "coada de email"
                echo -e "\n  DNS records pt email profesional:"
                printf "  ${Y}%-14s${N} ${DIM}%s${N}\n" "MX record" "indica serverul de email"
                printf "  ${Y}%-14s${N} ${DIM}%s${N}\n" "SPF record" "servere autorizate"
                printf "  ${Y}%-14s${N} ${DIM}%s${N}\n" "DKIM" "semnatura digitala"
                printf "  ${Y}%-14s${N} ${DIM}%s${N}\n" "DMARC" "politici SPF+DKIM")" ;;
            1) run_cmd "mailq 2>/dev/null || echo 'Postfix nu este activ'" ;;
            *) return ;;
        esac
    done
}

cap12_menu() {
    while true; do
        local c
        c=$(wmenu " Serverul E-mail " "Selectati un sub-capitol:" \
            "1" "Protocoale (SMTP, IMAP, POP3)" \
            "2" "Postfix: instalare si configurare" \
            "3" "Testare si monitorizare email" \
            "0" "<-- Meniu Principal") || return
        case $c in
            1)cap12_1;; 2)cap12_2;; 3)cap12_3;; *)return;;
        esac
    done
}

# ╔════════════════════════════════════════════════════════════╗
# ║  CAPITOLUL 13 — SERVERUL NTP                              ║
# ╚════════════════════════════════════════════════════════════╝

cap13_1() {
    while true; do
        local c
        c=$(wmenu " NTP " "Teorie sau ruleaza o comanda:" \
            "T" "[Teorie]  Network Time Protocol, Stratum" \
            "1" "timedatectl status           (starea ceasului)" \
            "0" "<-- Inapoi") || return
        case $c in
            T)  theory "$(echo -e "  ${W}${BOLD}NTP — Network Time Protocol${N}\n"
                echo -e "  ${C}▸${N} Sincronizeaza ceasul computerelor din retea"
                echo -e "  ${C}▸${N} Ceasuri nesincronizate: SSL invalid, erori loguri, probleme BD\n"
                echo -e "  Ierarhia Stratum:"
                printf "  ${Y}%-14s${N} ${DIM}%s${N}\n" "Stratum 0" "ceasuri atomice, GPS"
                printf "  ${Y}%-14s${N} ${DIM}%s${N}\n" "Stratum 1" "conectat direct la Stratum 0"
                printf "  ${Y}%-14s${N} ${DIM}%s${N}\n" "Stratum 2" "sincronizat cu Stratum 1"
                echo -e "\n  Servere NTP publice:"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "pool.ntp.org" "pool global"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "0.ro.pool.ntp.org" "pool Romania"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "time.google.com" "Google"
                echo -e "\n  Implementari Ubuntu:"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "systemd-timesyncd" "client simplu (default)"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "chrony" "client + server (recomandat)"
                printf "  ${Y}%-24s${N} ${DIM}%s${N}\n" "ntpd" "clasic")" ;;
            1) run_cmd "timedatectl status" ;;
            *) return ;;
        esac
    done
}

cap13_2() {
    while true; do
        local c
        c=$(wmenu " Configurare NTP " "Teorie sau ruleaza o comanda:" \
            "T" "[Teorie]  timesyncd, chrony" \
            "1" "timesyncd activ?             (systemctl)" \
            "2" "chronyc sources              (surse NTP)" \
            "0" "<-- Inapoi") || return
        case $c in
            T)  theory "$(echo -e "  ${W}${BOLD}Configurare NTP / Chrony${N}\n"
                echo -e "  systemd-timesyncd (implicit):"
                printf "  ${Y}%-30s${N} ${DIM}%s${N}\n" "/etc/systemd/timesyncd.conf" "fisier config"
                printf "  ${Y}%-30s${N} ${DIM}%s${N}\n" "timedatectl show-timesync" "starea sincronizarii"
                echo -e "\n  Chrony (mai puternic):"
                printf "  ${Y}%-30s${N} ${DIM}%s${N}\n" "sudo apt install chrony" "instaleaza"
                printf "  ${Y}%-30s${N} ${DIM}%s${N}\n" "/etc/chrony/chrony.conf" "fisier config"
                printf "  ${Y}%-30s${N} ${DIM}%s${N}\n" "chronyc sources -v" "surse NTP active"
                printf "  ${Y}%-30s${N} ${DIM}%s${N}\n" "chronyc tracking" "stare sincronizare"
                echo -e "\n  Server chrony (distribuie timp in LAN):"
                printf "  ${Y}%-30s${N} ${DIM}%s${N}\n" "allow 192.168.1.0/24" "permite clienti din retea"
                printf "  ${Y}%-30s${N} ${DIM}%s${N}\n" "local stratum 10" "fallback fara internet")" ;;
            1) run_cmd "systemctl is-active systemd-timesyncd 2>/dev/null && echo 'timesyncd: ACTIV' || echo 'timesyncd: inactiv'" ;;
            2) run_cmd "which chronyd 2>/dev/null && chronyc sources 2>/dev/null || echo 'Chrony nu este instalat (sudo apt install chrony)'" ;;
            *) return ;;
        esac
    done
}

cap13_3() {
    while true; do
        local c
        c=$(wmenu " Gestionarea Orei " "Teorie sau ruleaza o comanda:" \
            "T" "[Teorie]  date, timedatectl, hwclock" \
            "1" "timedatectl status           (stare completa)" \
            "2" "date (format personalizat)   (zi/luna/an ora)" \
            "3" "timedatectl list-timezones | grep Bucharest" \
            "0" "<-- Inapoi") || return
        case $c in
            T)  theory "$(echo -e "  ${W}${BOLD}Gestionarea Orei${N}\n"
                printf "  ${Y}%-34s${N} ${DIM}%s${N}\n" "date" "ora curenta"
                printf "  ${Y}%-34s${N} ${DIM}%s${N}\n" "date +\"%Y-%m-%d %H:%M\"" "format personalizat"
                printf "  ${Y}%-34s${N} ${DIM}%s${N}\n" "timedatectl status" "stare completa"
                printf "  ${Y}%-34s${N} ${DIM}%s${N}\n" "timedatectl list-timezones" "fusuri disponibile"
                printf "  ${Y}%-34s${N} ${DIM}%s${N}\n" "timedatectl set-timezone ..." "seteaza fus orar"
                printf "  ${Y}%-34s${N} ${DIM}%s${N}\n" "timedatectl set-ntp true" "activeaza NTP"
                printf "  ${Y}%-34s${N} ${DIM}%s${N}\n" "hwclock --show" "ceasul hardware (RTC)")" ;;
            1) run_cmd "timedatectl status" ;;
            2) run_cmd "date '+Data: %d/%m/%Y  |  Ora: %H:%M:%S  |  Timezone: %Z'" ;;
            3) run_cmd "timedatectl list-timezones | grep -i bucharest" ;;
            *) return ;;
        esac
    done
}

cap13_menu() {
    while true; do
        local c
        c=$(wmenu " Serverul NTP " "Selectati un sub-capitol:" \
            "1" "Ce este NTP (Stratum, servere publice)" \
            "2" "Configurare NTP / Chrony" \
            "3" "Gestionarea orei (date, timedatectl)" \
            "0" "<-- Meniu Principal") || return
        case $c in
            1)cap13_1;; 2)cap13_2;; 3)cap13_3;; *)return;;
        esac
    done
}

# ╔════════════════════════════════════════════════════════════╗
# ║  MENIU PRINCIPAL                                          ║
# ╚════════════════════════════════════════════════════════════╝

main_menu() {
    while true; do
        local c
        c=$(wmenu " LABORATOR LINUX - CURS INTERACTIV " \
            "IACOB COSTEL  |  Anul I ID  |  Grupa 106\n\nSelectati un capitol:" \
            "1" "Sistemul de Fisiere         (navigare, permisiuni, arhivare)" \
            "2" "Utilizatori si Permisiuni   (useradd, passwd, grupuri)" \
            "3" "Procese si Semnale          (ps, kill, bg/fg, systemd)" \
            "4" "Shell Scripting             (variabile, bucle, functii)" \
            "5" "Administrarea Software-ului (apt, dpkg, hardware)" \
            "6" "Configurarea Retelei        (ip, ping, dns, porturi)" \
            "7" "Serverul E-mail             (Postfix, SMTP, IMAP)" \
            "8" "Serverul NTP                (chrony, timedatectl)" \
            "0" "IESIRE") || exit 0
        case $c in
            1) cap3_menu  ;;
            2) cap4_menu  ;;
            3) cap5_menu  ;;
            4) cap6_menu  ;;
            5) cap7_menu  ;;
            6) cap8_menu  ;;
            7) cap12_menu ;;
            8) cap13_menu ;;
            0) clear; echo -e "\n  ${W}${BOLD}La revedere! Spor la invatat Linux!${N}\n"; exit 0 ;;
        esac
    done
}

# ── Start ─────────────────────────────────────────────────────
main_menu
