#!/bin/bash
# ╔══════════════════════════════════════════════════════════════╗
# ║          LABORATOR LINUX - CURS INTERACTIV                  ║
# ║──────────────────────────────────────────────────────────────║
# ║  Student : IACOB COSTEL                                     ║
# ║  Anul I ID | Grupa 106                                      ║
# ║  Bazat pe: InfoAcademy Linux - Cap. 3,4,5,6,7,8,12,13      ║
# ╚══════════════════════════════════════════════════════════════╝

# ── Culori ────────────────────────────────────────────────────
R='\033[0;31m'   G='\033[0;32m'   Y='\033[1;33m'
C='\033[0;36m'   B='\033[1;34m'   M='\033[0;35m'
W='\033[1;37m'   BOLD='\033[1m'   DIM='\033[2m'
N='\033[0m'      BG_B='\033[44m'

# ── Cleanup la iesire ─────────────────────────────────────────
DEMO_DIR="/tmp/.linux_curs_$$"
trap 'rm -rf "$DEMO_DIR" 2>/dev/null' EXIT

# ── Linia de separator ────────────────────────────────────────
L="══════════════════════════════════════════════════════════════"
S="──────────────────────────────────────────────────────────────"

# ╔════════════════════════════════════════════════════════════╗
# ║  FUNCTII DE AFISARE                                       ║
# ╚════════════════════════════════════════════════════════════╝

header() {
    clear
    echo -e "${C}╔${L}╗${N}"
    echo -e "${C}║${W}${BOLD}          LABORATOR LINUX - CURS INTERACTIV                  ${N}${C}║${N}"
    echo -e "${C}╠${L}╣${N}"
    echo -e "${C}║${Y}  IACOB COSTEL  │  Anul I ID  │  Grupa 106                   ${N}${C}║${N}"
    echo -e "${C}╚${L}╝${N}"
}

banner() {
    echo ""
    echo -e "  ${BG_B}${W}${BOLD}                                                            ${N}"
    printf "  ${BG_B}${W}${BOLD}  %-58s${N}\n" "$1"
    echo -e "  ${BG_B}${W}${BOLD}                                                            ${N}"
    echo ""
}

info() { echo -e "  ${C}▸${N} $1"; }
tip()  { echo -e "  ${G}TIP:${N} ${DIM}$1${N}"; }
warn() { echo -e "  ${R}ATENTIE:${N} $1"; }

cmd() {
    printf "  ${Y}%-32s${N} ${DIM}# %s${N}\n" "$1" "$2"
}

run() {
    echo -e "\n  ${Y}┌── \$ ${BOLD}$1${N}"
    echo -e "  ${Y}│${N}"
    eval "$1" 2>&1 | sed 's/^/  │  /'
    local rc=$?
    echo -e "  ${Y}│${N}"
    if [[ $rc -eq 0 ]]; then
        echo -e "  ${Y}└── ${G}exit code: 0${N}"
    else
        echo -e "  ${Y}└── ${R}exit code: $rc${N}"
    fi
    echo ""
}

ask_run() {
    echo -ne "  ${G}▶${N} Rulam: ${BOLD}$1${N} ? ${DIM}[D/n]${N} "
    read -r ans
    ans=${ans:-d}
    if [[ "${ans,,}" =~ ^(d|y|da)$ ]]; then
        run "$1"
    else
        echo -e "  ${DIM}  (sarit)${N}"
        echo ""
    fi
}

pause() {
    echo ""
    echo -e "  ${DIM}${S}${N}"
    echo -ne "  ${G}Apasati ENTER pentru a continua...${N} "
    read -r
}

invalid() { echo -e "\n  ${R}Optiune invalida!${N}"; sleep 0.7; }

# ╔════════════════════════════════════════════════════════════╗
# ║  CAPITOLUL 3 — SISTEMUL DE FISIERE                        ║
# ╚════════════════════════════════════════════════════════════╝

cap3_1() {
    header; banner "Structura Sistemului de Fisiere (FHS)"
    info "Linux foloseste o structura ierarhica pornind din radacina '/' (root)."
    info "Spre deosebire de Windows, nu exista litere de drive (C:, D:)."
    echo ""
    info "Directoare standard importante:"
    cmd "/home"     "directoarele utilizatorilor"
    cmd "/etc"      "fisiere de configurare"
    cmd "/var"      "date variabile (loguri, spool)"
    cmd "/tmp"      "fisiere temporare"
    cmd "/bin"      "comenzi de baza (ls, cp, mv)"
    cmd "/usr"      "software instalat"
    cmd "/proc"     "info procese/kernel (virtual)"
    cmd "/dev"      "dispozitive (HDD, USB)"
    echo ""
    info "Hai sa vedem structura radacinii:"
    run "ls -la / --color=auto"
    info "Si tipurile de sisteme de fisiere montate:"
    run "df -Th | head -12"
    pause
}

cap3_2() {
    header; banner "Navigare: pwd, ls, cd"
    info "Comenzile esentiale pentru navigare in terminal:"
    echo ""
    cmd "pwd"              "afiseaza calea curenta"
    cmd "ls -l"            "lista lunga (permisiuni, marime)"
    cmd "ls -la"           "include fisiere ascunse (.)"
    cmd "ls -lh"           "marimi human-readable"
    cmd "cd ~"             "home directory"
    cmd "cd .."            "un nivel in sus"
    cmd "cd -"             "directorul anterior"
    echo ""
    info "Demonstratie navigare:"
    run "pwd"
    run "ls -lah ~ | head -15"
    run "ls -lah /etc/ | head -15"
    tip "Folositi TAB pentru auto-complete la cai de fisiere!"
    pause
}

cap3_3() {
    header; banner "Operatii cu Fisiere: touch, mkdir, cp, mv, rm"
    info "Comenzile de baza pentru fisiere si directoare:"
    echo ""
    cmd "touch fisier.txt"          "creeaza fisier gol"
    cmd "mkdir -p dir1/dir2"        "creeaza directoare nested"
    cmd "cp sursa dest"             "copiaza fisier"
    cmd "cp -r dir1/ dir2/"         "copiaza director recursiv"
    cmd "mv vechi nou"              "redenumeste/muta"
    cmd "rm fisier"                 "sterge fisier"
    cmd "rm -rf director/"          "sterge director (PERICULOS!)"
    cmd "cat fisier"                "afiseaza continut"
    cmd "head -5 / tail -5"         "primele/ultimele linii"
    echo ""
    warn "rm -rf este ireversibil! Verificati intotdeauna calea."
    echo ""
    info "Demo: cream, manipulam si curatam fisiere temporare:"
    mkdir -p "$DEMO_DIR"
    run "mkdir -p $DEMO_DIR/proiect/src $DEMO_DIR/proiect/docs && echo 'Directoare create!'"
    run "echo 'Salut Linux!' > $DEMO_DIR/proiect/readme.txt && cat $DEMO_DIR/proiect/readme.txt"
    run "cp $DEMO_DIR/proiect/readme.txt $DEMO_DIR/proiect/docs/copie.txt && ls -la $DEMO_DIR/proiect/docs/"
    run "tree $DEMO_DIR/proiect 2>/dev/null || find $DEMO_DIR/proiect -type f"
    run "rm -rf $DEMO_DIR/proiect && echo 'Curatat!'"
    pause
}

cap3_4() {
    header; banner "Permisiuni: chmod, chown (rwx / octal)"
    info "Fiecare fisier are 3 seturi de permisiuni: proprietar(u), grup(g), altii(o)"
    info "Drepturi: r=citire(4), w=scriere(2), x=executie(1)"
    echo ""
    info "Combinatii octal frecvente:"
    cmd "755 = rwxr-xr-x"   "executabil/script"
    cmd "644 = rw-r--r--"   "fisier text obisnuit"
    cmd "700 = rwx------"   "acces doar proprietar"
    cmd "600 = rw-------"   "fisier privat (chei SSH)"
    echo ""
    cmd "chmod 755 script.sh"      "seteaza permisiuni octal"
    cmd "chmod u+x script.sh"      "adauga executie proprietar"
    cmd "chmod -R 755 dir/"        "recursiv"
    cmd "chown user:grup fisier"   "schimba proprietar"
    echo ""
    info "Exemplu real — diferenta intre fisiere publice si protejate:"
    run "ls -la /etc/passwd /etc/shadow 2>/dev/null || ls -la /etc/passwd"
    info "/etc/shadow are permisiuni restrictive deoarece contine hash-urile parolelor."
    echo ""
    info "Demo: cream un script si ii setam permisiunile:"
    mkdir -p "$DEMO_DIR"
    echo '#!/bin/bash' > "$DEMO_DIR/test.sh"
    echo 'echo "Script executat cu succes!"' >> "$DEMO_DIR/test.sh"
    run "ls -l $DEMO_DIR/test.sh"
    run "chmod 755 $DEMO_DIR/test.sh && ls -l $DEMO_DIR/test.sh"
    run "$DEMO_DIR/test.sh"
    pause
}

cap3_5() {
    header; banner "Cautare: find, locate, grep, which"
    info "Comenzi puternice pentru gasirea fisierelor si textului:"
    echo ""
    cmd "find /etc -name '*.conf'"       "cauta dupa nume"
    cmd "find / -size +100M"             "fisiere mari"
    cmd "find . -mtime -1"               "modificate azi"
    cmd "find . -type d"                 "doar directoare"
    cmd "grep 'text' fisier"             "cauta text in fisier"
    cmd "grep -r 'text' /etc/"           "recursiv in director"
    cmd "grep -i 'text' fisier"          "case-insensitive"
    cmd "which comanda"                  "calea executabilului"
    echo ""
    info "Demonstratii live:"
    run "find /etc -maxdepth 1 -name '*.conf' 2>/dev/null | head -10"
    run "which bash python3 ls 2>/dev/null"
    run "grep -c 'bash' /etc/passwd && echo 'utilizatori cu bash shell'"
    run "grep -v 'nologin' /etc/passwd | head -5"
    pause
}

cap3_6() {
    header; banner "Arhivare: tar, gzip, zip"
    info "tar grupeaza fisiere; gzip/bzip2/xz le comprima."
    echo ""
    cmd "tar -czvf arhiva.tar.gz dir/"   "creeaza arhiva gzip"
    cmd "tar -xzvf arhiva.tar.gz"        "dezarhiveaza"
    cmd "tar -tzvf arhiva.tar.gz"        "listeaza continut"
    cmd "gzip fisier / gunzip fisier.gz" "comprima/decomprima"
    cmd "zip -r arhiva.zip dir/"         "format zip"
    echo ""
    info "Memotehnic tar: ${BOLD}c${N}reate, e${BOLD}x${N}tract, lis${BOLD}t${N} | ${BOLD}z${N}=gzip ${BOLD}j${N}=bzip2 | ${BOLD}v${N}erbose ${BOLD}f${N}ile"
    echo ""
    info "Demo: arhivam /etc/hosts si afisam continutul:"
    mkdir -p "$DEMO_DIR"
    run "tar -czvf $DEMO_DIR/demo.tar.gz /etc/hosts /etc/hostname 2>/dev/null"
    run "ls -lh $DEMO_DIR/demo.tar.gz"
    run "tar -tzvf $DEMO_DIR/demo.tar.gz"
    pause
}

cap3_menu() {
    while true; do
        header; banner "Sistemul de Fisiere"
        echo -e "  ${C}1.${N} Structura FHS (/, /home, /etc, /var)"
        echo -e "  ${C}2.${N} Navigare (pwd, ls, cd)"
        echo -e "  ${C}3.${N} Operatii fisiere (touch, mkdir, cp, mv, rm)"
        echo -e "  ${C}4.${N} Permisiuni (chmod, chown, octal)"
        echo -e "  ${C}5.${N} Cautare (find, grep, which)"
        echo -e "  ${C}6.${N} Arhivare (tar, gzip, zip)"
        echo -e "  ${R}0.${N} Inapoi"
        echo -e "\n  ${C}${S}${N}"
        echo -ne "  Alegeti (0-6): "; read -r o
        case $o in 1)cap3_1;; 2)cap3_2;; 3)cap3_3;; 4)cap3_4;; 5)cap3_5;; 6)cap3_6;; 0)return;; *)invalid;; esac
    done
}

# ╔════════════════════════════════════════════════════════════╗
# ║  CAPITOLUL 4 — UTILIZATORI SI PERMISIUNI                  ║
# ╚════════════════════════════════════════════════════════════╝

cap4_1() {
    header; banner "Informatii despre Utilizatori"
    info "Fiecare utilizator are un UID unic si un grup primar (GID)."
    info "Datele sunt stocate in:"
    echo ""
    cmd "/etc/passwd"    "user:x:UID:GID:Comentariu:Home:Shell"
    cmd "/etc/shadow"    "parole criptate (doar root)"
    cmd "/etc/group"     "definitii grupuri"
    echo ""
    cmd "whoami"         "utilizatorul curent"
    cmd "id"             "UID, GID, grupuri"
    cmd "who / w"        "utilizatori conectati"
    cmd "last"           "istoricul conectarilor"
    echo ""
    info "Cine esti?"
    run "whoami"
    run "id"
    info "Primele intrari din /etc/passwd (formatul USER:x:UID:GID:INFO:HOME:SHELL):"
    run "head -5 /etc/passwd"
    run "w 2>/dev/null || who"
    pause
}

cap4_2() {
    header; banner "Crearea Utilizatorilor (useradd / adduser)"
    cmd "useradd -m user"           "creeaza user cu home dir"
    cmd "useradd -m -s /bin/bash u" "cu shell specificat"
    cmd "useradd -m -G sudo,g1 u"  "cu grupuri suplimentare"
    cmd "adduser user"              "mod interactiv (recomandat)"
    cmd "passwd user"               "seteaza/schimba parola"
    echo ""
    if [[ $EUID -eq 0 ]]; then
        info "Aveti root — demonstram crearea si stergerea unui user de test:"
        run "useradd -m -s /bin/bash -c 'Utilizator Demo' demo_curs 2>/dev/null && echo 'Creat!' || echo 'Exista deja'"
        run "id demo_curs"
        run "ls -la /home/demo_curs/"
        run "userdel -r demo_curs 2>/dev/null && echo 'Sters!'"
    else
        warn "Demo-ul complet necesita root. Rulati cu: ${BOLD}sudo bash $0${N}"
        echo ""
        info "Utilizatori cu shell interactiv pe acest sistem:"
        run "grep -v 'nologin\|false' /etc/passwd | cut -d: -f1,3,6,7"
    fi
    pause
}

cap4_3() {
    header; banner "Modificarea Utilizatorilor (usermod)"
    cmd "usermod -aG sudo user"    "adauga in grup (APPEND!)"
    cmd "usermod -s /bin/zsh user" "schimba shell"
    cmd "usermod -d /home/new -m"  "schimba home + muta"
    cmd "usermod -L user"          "Lock (blocheaza contul)"
    cmd "usermod -U user"          "Unlock (deblocheaza)"
    cmd "usermod -e 2026-12-31 u"  "data expirare cont"
    echo ""
    warn "Folositi ${BOLD}-aG${N} (cu -a!) pentru a adauga la grup. Fara -a suprascrie grupurile!"
    echo ""
    cmd "chage -l user"            "info expirare parola"
    cmd "chage -M 90 user"        "parola expira la 90 zile"
    echo ""
    info "Informatii cont curent:"
    run "chage -l $(whoami) 2>/dev/null || echo 'chage necesita permisiuni root'"
    run "grep ^$(whoami) /etc/passwd"
    pause
}

cap4_4() {
    header; banner "Stergerea Utilizatorilor (userdel)"
    cmd "userdel user"       "sterge (pastreaza /home)"
    cmd "userdel -r user"    "sterge + home directory"
    echo ""
    info "Inainte de stergere, verificati:"
    cmd "find / -user user"  "fisierele detinute"
    cmd "pkill -u user"      "opriti procesele active"
    echo ""
    info "Fisiere fara proprietar pe sistem (dupa stergeri incomplete):"
    run "find /tmp -maxdepth 2 -nouser 2>/dev/null | head -5 || echo 'Niciun fisier orfan gasit in /tmp'"
    pause
}

cap4_5() {
    header; banner "Gestionarea Grupurilor"
    cmd "groups"                    "grupurile mele"
    cmd "groupadd dezvoltatori"     "creeaza grup"
    cmd "groupmod -n new old"       "redenumeste"
    cmd "groupdel grup"             "sterge"
    cmd "usermod -aG grup user"     "adauga user la grup"
    echo ""
    info "Grupurile tale:"
    run "groups $(whoami)"
    info "Ultimele grupuri definite pe sistem:"
    run "tail -10 /etc/group"
    pause
}

cap4_menu() {
    while true; do
        header; banner "Utilizatori si Permisiuni"
        echo -e "  ${C}1.${N} Informatii utilizatori (whoami, id, /etc/passwd)"
        echo -e "  ${C}2.${N} Crearea utilizatorilor (useradd, adduser)"
        echo -e "  ${C}3.${N} Modificarea utilizatorilor (usermod, chage)"
        echo -e "  ${C}4.${N} Stergerea utilizatorilor (userdel)"
        echo -e "  ${C}5.${N} Gestionarea grupurilor (groupadd, groupdel)"
        echo -e "  ${R}0.${N} Inapoi"
        echo -e "\n  ${C}${S}${N}"
        echo -ne "  Alegeti (0-5): "; read -r o
        case $o in 1)cap4_1;; 2)cap4_2;; 3)cap4_3;; 4)cap4_4;; 5)cap4_5;; 0)return;; *)invalid;; esac
    done
}

# ╔════════════════════════════════════════════════════════════╗
# ║  CAPITOLUL 5 — PROCESE SI SEMNALE                         ║
# ╚════════════════════════════════════════════════════════════╝

cap5_1() {
    header; banner "Afisarea si Monitorizarea Proceselor"
    info "Un proces = un program in executie, identificat prin PID unic."
    info "PID 1 (systemd/init) e parintele tuturor proceselor."
    echo ""
    cmd "ps aux"         "TOATE procesele (format BSD)"
    cmd "ps -ef"         "TOATE procesele (format UNIX)"
    cmd "ps aux | grep X" "cauta un proces"
    cmd "top"            "monitor interactiv (q=iesire)"
    cmd "htop"           "versiune imbunatatita (apt install htop)"
    cmd "pstree"         "arbore de procese"
    echo ""
    info "Coloane ps aux: USER PID %CPU %MEM VSZ RSS STAT COMMAND"
    info "STAT: R=running S=sleeping Z=zombie T=stopped D=I/O wait"
    echo ""
    run "ps aux --sort=-%cpu | head -12"
    run "pstree -p | head -20"
    pause
}

cap5_2() {
    header; banner "Background / Foreground / Jobs"
    info "Procesele pot rula in prim-plan (foreground) sau in fundal (background)."
    echo ""
    cmd "comanda &"      "porneste in background"
    cmd "Ctrl+Z"         "suspenda procesul curent"
    cmd "bg / bg %N"     "continua in background"
    cmd "fg / fg %N"     "aduce in foreground"
    cmd "jobs -l"        "listeaza job-uri"
    cmd "nohup cmd &"    "supravietuieste logout-ului"
    cmd "disown"         "detaseaza job de terminal"
    echo ""
    info "Demo: pornim un proces in background, il vedem si il oprim:"
    run "sleep 60 & echo \"PID: \$!\" && jobs -l && kill %1 2>/dev/null && echo 'Proces oprit.'"
    pause
}

cap5_3() {
    header; banner "Semnale: kill, killall, pkill"
    info "Semnalele controleaza procesele. Importante:"
    echo ""
    cmd "SIGHUP  (1)"    "reload configuratie / terminare la logout"
    cmd "SIGINT  (2)"    "intrerupe (Ctrl+C)"
    cmd "SIGKILL (9)"    "fortat — nu poate fi ignorat!"
    cmd "SIGTERM (15)"   "terminare eleganta (default kill)"
    cmd "SIGCONT (18)"   "continua proces suspendat"
    cmd "SIGSTOP (19)"   "suspenda — nu poate fi ignorat"
    echo ""
    cmd "kill PID"           "trimite SIGTERM"
    cmd "kill -9 PID"        "SIGKILL (fortat)"
    cmd "killall firefox"    "opreste dupa nume"
    cmd "pkill -u user"      "opreste dupa utilizator"
    echo ""
    info "Lista completa a semnalelor disponibile:"
    run "kill -l"
    info "Demo — pornim un proces, ii trimitem SIGTERM, verificam:"
    run "sleep 120 & PID=\$!; echo \"Proces PID=\$PID\"; kill \$PID; wait \$PID 2>/dev/null; echo \"Proces terminat.\""
    pause
}

cap5_4() {
    header; banner "Prioritati: nice, renice"
    info "Prioritatea determina cat CPU primeste un proces (nice: -20 la +19)."
    info "Valoare mica = prioritate mai mare. Doar root poate seta negativ."
    echo ""
    cmd "nice -n 10 comanda"     "porneste cu prioritate redusa"
    cmd "nice -n -5 comanda"     "prioritate ridicata (root)"
    cmd "renice 5 -p PID"       "modifica un proces activ"
    echo ""
    info "Procesele cu cele mai mari valori nice:"
    run "ps -eo pid,ni,user,comm --sort=-ni | head -12"
    pause
}

cap5_5() {
    header; banner "Servicii si Systemd"
    info "Ubuntu foloseste systemd pentru gestionarea serviciilor (daemon-urilor)."
    echo ""
    cmd "systemctl status serv"     "starea serviciului"
    cmd "systemctl start serv"      "porneste"
    cmd "systemctl stop serv"       "opreste"
    cmd "systemctl restart serv"    "reporneste"
    cmd "systemctl enable serv"     "pornire automata la boot"
    cmd "systemctl disable serv"    "dezactiveaza la boot"
    cmd "journalctl -u serv -f"     "loguri live"
    echo ""
    info "Servicii active pe sistemul tau:"
    run "systemctl list-units --type=service --state=running 2>/dev/null | head -15 || echo 'systemctl indisponibil (WSL fara systemd?)'"
    pause
}

cap5_menu() {
    while true; do
        header; banner "Procese si Semnale"
        echo -e "  ${C}1.${N} Afisarea proceselor (ps, top, pstree)"
        echo -e "  ${C}2.${N} Background / Foreground (bg, fg, jobs)"
        echo -e "  ${C}3.${N} Semnale (kill, killall, pkill)"
        echo -e "  ${C}4.${N} Prioritati (nice, renice)"
        echo -e "  ${C}5.${N} Servicii si Systemd (systemctl)"
        echo -e "  ${R}0.${N} Inapoi"
        echo -e "\n  ${C}${S}${N}"
        echo -ne "  Alegeti (0-5): "; read -r o
        case $o in 1)cap5_1;; 2)cap5_2;; 3)cap5_3;; 4)cap5_4;; 5)cap5_5;; 0)return;; *)invalid;; esac
    done
}

# ╔════════════════════════════════════════════════════════════╗
# ║  CAPITOLUL 6 — SHELL SCRIPTING                            ║
# ╚════════════════════════════════════════════════════════════╝

cap6_1() {
    header; banner "Variabile"
    info "Variabilele stocheaza date in sesiunea curenta de shell."
    echo ""
    cmd "NUME='Costel'"         "atribuire (fara spatii la =)"
    cmd 'echo $NUME'            "afiseaza valoarea"
    cmd 'echo "Salut $NUME"'    "expansiune in ghilimele duble"
    cmd "echo 'Salut \$NUME'"   "fara expansiune in simple"
    cmd 'SUMA=$((3+4))'         "calcul aritmetic"
    cmd 'DATA=$(date)'          "captura output comanda"
    cmd "export VAR='val'"      "accesibila in subprocese"
    echo ""
    info "Variabile de mediu predefinite:"
    cmd "\$HOME"     "directorul home"
    cmd "\$PATH"     "caile de cautare executabile"
    cmd "\$USER"     "utilizator curent"
    cmd "\$SHELL"    "shell-ul curent"
    cmd "\$PWD"      "director curent"
    echo ""
    run 'echo "HOME=$HOME | USER=$USER | SHELL=$SHELL"'
    run 'echo "PATH=$PATH" | tr ":" "\n" | head -5'
    run 'echo "Calcul: 15 * 7 + 3 = $((15 * 7 + 3))"'
    run 'ORAS="Bucuresti"; echo "Buna dimineata din $ORAS! Data: $(date +%d/%m/%Y)"'
    pause
}

cap6_2() {
    header; banner "Citirea Datelor: read si Argumente"
    cmd "read VAR"             "citeste o linie"
    cmd "read -p 'Msg: ' VAR" "cu prompt"
    cmd "read -s VAR"          "silent (parole)"
    cmd "read -t 5 VAR"        "timeout 5 secunde"
    echo ""
    info "Variabile speciale pentru argumente in scripturi:"
    cmd "\$0"     "numele scriptului"
    cmd "\$1 \$2"  "argumentele pozitionale"
    cmd "\$#"     "numarul de argumente"
    cmd "\$@"     "toate argumentele (lista)"
    cmd "\$?"     "exit code ultima comanda (0=succes)"
    cmd "\$\$"    "PID script curent"
    echo ""
    run 'echo "Script: $0  |  PID: $$  |  User: $USER"'
    info "Demo: citim input de la tine:"
    echo -ne "  ${G}▶${N} Scrie numele tau: "
    read -r DEMO_NUME
    DEMO_NUME=${DEMO_NUME:-Student}
    echo -e "\n  ${W}Salut, ${BOLD}${DEMO_NUME}${N}${W}! Bine ai venit in Shell Scripting.${N}\n"
    pause
}

cap6_3() {
    header; banner "Structuri Conditionale: if / case"
    info "Sintaxa if:"
    echo -e "  ${Y}  if [ conditie ]; then${N}"
    echo -e "  ${Y}      comenzi${N}"
    echo -e "  ${Y}  elif [ alta ]; then${N}"
    echo -e "  ${Y}      comenzi${N}"
    echo -e "  ${Y}  else${N}"
    echo -e "  ${Y}      comenzi${N}"
    echo -e "  ${Y}  fi${N}"
    echo ""
    info "Operatori numerici: -eq -ne -lt -le -gt -ge"
    info "Operatori siruri: = != -z(gol) -n(nevid)"
    info "Operatori fisiere: -f(fisier) -d(director) -e(exista) -r -w -x"
    echo ""
    run 'VARSTA=20; if [ $VARSTA -ge 18 ]; then echo "Major ($VARSTA ani)"; else echo "Minor"; fi'
    run 'if [ -f /etc/hosts ]; then echo "/etc/hosts exista ($(wc -l < /etc/hosts) linii)"; fi'
    run 'if [ -d /etc/apt ]; then echo "Sistem bazat pe APT (Debian/Ubuntu)"; fi'
    run '[[ $(uname -s) == "Linux" ]] && echo "Sistem de operare: Linux ($(uname -r))" || echo "Alt SO"'
    pause
}

cap6_4() {
    header; banner "Bucle: for / while / until"
    echo -e "  ${Y}  for var in lista; do ... done${N}"
    echo -e "  ${Y}  while [ cond ]; do ... done${N}"
    echo -e "  ${Y}  until [ cond ]; do ... done${N}"
    echo ""
    cmd "break"     "iese din bucla"
    cmd "continue"  "sare la iteratia urmatoare"
    echo ""
    run 'for i in 1 2 3 4 5; do echo "  Iteratia $i: $(date +%H:%M:%S.%N | cut -c1-12)"; done'
    run 'for user in $(cut -d: -f1 /etc/passwd | head -5); do echo "  User: $user"; done'
    run 'COUNT=1; while [ $COUNT -le 5 ]; do echo "  While #$COUNT"; COUNT=$((COUNT+1)); done'
    run 'for f in /etc/*.conf; do [ -f "$f" ] && echo "  $(basename "$f") ($(wc -l < "$f") linii)"; done 2>/dev/null | head -8'
    pause
}

cap6_5() {
    header; banner "Functii"
    info "Functiile grupeaza comenzi reutilizabile:"
    echo -e "  ${Y}  functie() {${N}"
    echo -e "  ${Y}      comenzi${N}"
    echo -e "  ${Y}      return 0${N}"
    echo -e "  ${Y}  }${N}"
    echo ""
    info "Argumente: \$1, \$2 ... | return seteaza \$?"
    echo ""
    run 'salut() { echo "Buna, $1! Ai $2 ani."; }; salut "Costel" "20"'
    run 'patrat() { echo $(($1 * $1)); }; echo "9 la patrat = $(patrat 9)"'
    run 'info_fisier() {
    if [ -f "$1" ]; then
        echo "  Fisier  : $1"
        echo "  Marime  : $(du -h "$1" | cut -f1)"
        echo "  Linii   : $(wc -l < "$1")"
        echo "  Drepturi: $(stat -c %A "$1" 2>/dev/null || stat -f %Sp "$1" 2>/dev/null)"
    else
        echo "  $1 nu exista!"
    fi
}
info_fisier /etc/hosts
info_fisier /etc/fisier_inexistent'
    pause
}

cap6_6() {
    header; banner "Filtre si Pipe: grep, sed, awk, sort, cut"
    info "Pipe (|) redirectioneaza output-ul unei comenzi ca input la urmatoarea."
    echo ""
    cmd "grep 'text' fisier"        "cauta pattern"
    cmd "sed 's/vechi/nou/g'"       "substitutie text"
    cmd "awk -F: '{print \$1}'"     "extrage coloane"
    cmd "sort / sort -rn"           "sorteaza"
    cmd "uniq"                      "elimina duplicate adiacente"
    cmd "cut -d: -f1,3"            "extrage campuri"
    cmd "wc -l"                     "numara linii"
    cmd "tr 'a-z' 'A-Z'"           "transforma caractere"
    echo ""
    info "Exemple live cu pipe-uri complexe:"
    run "cut -d: -f1,3,7 /etc/passwd | sort -t: -k2 -n | tail -10"
    run "ps aux --sort=-%mem | awk 'NR<=6 {printf \"%-12s %5s %5s %s\n\", \$1, \$3, \$4, \$11}'"
    run "echo 'hello linux world!' | tr 'a-z' 'A-Z'"
    run "df -h | grep -v tmpfs | awk '{printf \"%-20s %s folosit\n\", \$1, \$5}'"
    pause
}

cap6_menu() {
    while true; do
        header; banner "Shell Scripting"
        echo -e "  ${C}1.${N} Variabile (declarare, export, \$HOME \$PATH)"
        echo -e "  ${C}2.${N} Citire date (read, argumente \$1 \$# \$@)"
        echo -e "  ${C}3.${N} Conditii (if, elif, operatori)"
        echo -e "  ${C}4.${N} Bucle (for, while, until)"
        echo -e "  ${C}5.${N} Functii (declarare, return)"
        echo -e "  ${C}6.${N} Filtre si pipe (grep, sed, awk, sort)"
        echo -e "  ${R}0.${N} Inapoi"
        echo -e "\n  ${C}${S}${N}"
        echo -ne "  Alegeti (0-6): "; read -r o
        case $o in 1)cap6_1;; 2)cap6_2;; 3)cap6_3;; 4)cap6_4;; 5)cap6_5;; 6)cap6_6;; 0)return;; *)invalid;; esac
    done
}

# ╔════════════════════════════════════════════════════════════╗
# ║  CAPITOLUL 7 — ADMINISTRAREA SOFTWARE-ULUI                ║
# ╚════════════════════════════════════════════════════════════╝

cap7_1() {
    header; banner "Gestiunea Pachetelor cu APT"
    info "Ubuntu/Debian folosesc APT (Advanced Package Tool)."
    info "Pachetele (.deb) sunt in repository-uri (depozite online)."
    echo ""
    cmd "apt update"             "actualizeaza lista"
    cmd "apt upgrade"            "actualizeaza pachetele"
    cmd "apt install pachet"     "instaleaza"
    cmd "apt remove pachet"      "dezinstaleaza (pastreaza config)"
    cmd "apt purge pachet"       "dezinstaleaza complet"
    cmd "apt autoremove"         "sterge dependente orfane"
    cmd "apt search cuvant"      "cauta pachet"
    cmd "apt show pachet"        "detalii pachet"
    cmd "dpkg -l"                "lista pachete (nivel jos)"
    echo ""
    run "apt list --installed 2>/dev/null | wc -l | xargs -I{} echo '{} pachete instalate pe acest sistem'"
    run "dpkg -l | tail -10"
    pause
}

cap7_2() {
    header; banner "Instalare si Dezinstalare Pachete"
    info "Flux tipic de instalare:"
    echo ""
    echo -e "  ${Y}  sudo apt update              ${DIM}# 1. Actualizeaza lista${N}"
    echo -e "  ${Y}  sudo apt install htop -y     ${DIM}# 2. Instaleaza${N}"
    echo -e "  ${Y}  which htop                   ${DIM}# 3. Verifica${N}"
    echo ""
    info "Dezinstalare:"
    cmd "sudo apt remove htop"     "pastreaza config"
    cmd "sudo apt purge htop"      "sterge totul"
    cmd "sudo apt autoremove"      "curata dependente"
    echo ""
    info "Informatii despre un pachet:"
    run "apt-cache show curl 2>/dev/null | grep -E '(Package|Version|Installed-Size|Description-en)' | head -5"
    run "dpkg -L bash | head -10"
    pause
}

cap7_3() {
    header; banner "Informatii Hardware si Analiza Sistem"
    info "Linux ofera comenzi bogate pentru analiza hardware:"
    echo ""
    cmd "lscpu"       "procesor (arhitectura, core-uri)"
    cmd "free -h"     "memorie RAM si swap"
    cmd "lsblk"       "dispozitive stocare"
    cmd "df -h"       "spatiu disk"
    cmd "lspci"       "dispozitive PCI"
    cmd "lsusb"       "dispozitive USB"
    cmd "uname -a"    "kernel si arhitectura"
    cmd "uptime"      "timp rulare + load average"
    echo ""
    info "Output real de pe sistemul tau:"
    run "uname -a"
    run "lscpu | grep -E '(Architecture|Model name|CPU\(s\)|Thread|Core|Socket|MHz)'"
    run "free -h"
    run "df -h | grep -v tmpfs | grep -v loop"
    run "lsblk 2>/dev/null | head -10"
    run "uptime"
    pause
}

cap7_menu() {
    while true; do
        header; banner "Administrarea Software-ului"
        echo -e "  ${C}1.${N} Gestiunea pachetelor APT"
        echo -e "  ${C}2.${N} Instalare si dezinstalare"
        echo -e "  ${C}3.${N} Informatii hardware (lscpu, free, df, lsblk)"
        echo -e "  ${R}0.${N} Inapoi"
        echo -e "\n  ${C}${S}${N}"
        echo -ne "  Alegeti (0-3): "; read -r o
        case $o in 1)cap7_1;; 2)cap7_2;; 3)cap7_3;; 0)return;; *)invalid;; esac
    done
}

# ╔════════════════════════════════════════════════════════════╗
# ║  CAPITOLUL 8 — CONFIGURAREA RETELEI                       ║
# ╚════════════════════════════════════════════════════════════╝

cap8_1() {
    header; banner "Interfete de Retea (ip addr, ifconfig)"
    info "Interfetele sunt canalele de comunicare cu reteaua."
    echo ""
    cmd "ip addr"         "adresele IP ale interfetelor"
    cmd "ip link"         "starea interfetelor (up/down)"
    cmd "ifconfig"        "comanda clasica (deprecated)"
    echo ""
    info "Tipuri comune de interfete:"
    cmd "eth0 / enp3s0"   "Ethernet cablata"
    cmd "wlan0 / wlp2s0"  "WiFi"
    cmd "lo"              "loopback (127.0.0.1)"
    echo ""
    info "CIDR: 192.168.1.100/24 = IP + masca (/24 = 255.255.255.0)"
    echo ""
    info "Interfetele tale:"
    run "ip -br addr"
    run "ip addr show | grep -E '(^[0-9]|inet )'"
    pause
}

cap8_2() {
    header; banner "Testare Conectivitate: ping, traceroute"
    cmd "ping -c 4 host"       "4 pachete ICMP"
    cmd "traceroute host"      "urmareste ruta"
    cmd "tracepath host"       "fara root"
    cmd "mtr host"             "ping + traceroute interactiv"
    echo ""
    info "Testam conectivitatea la internet:"
    run "ping -c 3 8.8.8.8"
    ask_run "ping -c 3 google.com"
    info "Ruta spre Google DNS:"
    ask_run "tracepath -m 10 8.8.8.8 2>/dev/null || traceroute -m 10 8.8.8.8 2>/dev/null || echo 'traceroute/tracepath indisponibil'"
    pause
}

cap8_3() {
    header; banner "Rutare si Gateway (ip route)"
    cmd "ip route"                    "tabela de rutare"
    cmd "ip route get 8.8.8.8"        "pe ce interfata iese"
    cmd "ip route add ... via ..."    "adauga ruta"
    cmd "ip route del ..."            "sterge ruta"
    echo ""
    info "Tabela ta de rutare:"
    run "ip route show"
    run "ip route get 8.8.8.8 2>/dev/null"
    pause
}

cap8_4() {
    header; banner "Porturi si Servicii (ss, netstat)"
    info "Porturile identifica serviciile pe un host."
    cmd "HTTP=80"      "HTTPS=443"
    cmd "SSH=22"       "FTP=21"
    cmd "DNS=53"       "SMTP=25"
    echo ""
    cmd "ss -tuln"          "porturi in ascultare (TCP/UDP)"
    cmd "ss -tulnp"         "cu procesul asociat (root)"
    cmd "netstat -tuln"     "varianta clasica"
    echo ""
    info "Porturile deschise pe sistemul tau:"
    run "ss -tuln"
    pause
}

cap8_5() {
    header; banner "DNS: nslookup, dig, /etc/hosts"
    info "DNS traduce hostname-uri in adrese IP."
    echo ""
    cmd "nslookup google.com"        "interogare DNS"
    cmd "dig +short google.com"      "doar IP-ul"
    cmd "host google.com"            "interogare rapida"
    cmd "/etc/resolv.conf"           "servere DNS configurate"
    cmd "/etc/hosts"                 "rezolutie locala manuala"
    echo ""
    info "Configuratia DNS si rezolutie live:"
    run "cat /etc/resolv.conf"
    run "nslookup google.com 2>/dev/null || host google.com 2>/dev/null || echo 'nslookup/host indisponibil'"
    run "cat /etc/hosts"
    pause
}

cap8_menu() {
    while true; do
        header; banner "Configurarea Retelei"
        echo -e "  ${C}1.${N} Interfete de retea (ip addr, ifconfig)"
        echo -e "  ${C}2.${N} Testare conectivitate (ping, traceroute)"
        echo -e "  ${C}3.${N} Rutare si gateway (ip route)"
        echo -e "  ${C}4.${N} Porturi si servicii (ss, netstat)"
        echo -e "  ${C}5.${N} DNS (nslookup, dig, /etc/hosts)"
        echo -e "  ${R}0.${N} Inapoi"
        echo -e "\n  ${C}${S}${N}"
        echo -ne "  Alegeti (0-5): "; read -r o
        case $o in 1)cap8_1;; 2)cap8_2;; 3)cap8_3;; 4)cap8_4;; 5)cap8_5;; 0)return;; *)invalid;; esac
    done
}

# ╔════════════════════════════════════════════════════════════╗
# ║  CAPITOLUL 12 — SERVERUL E-MAIL                           ║
# ╚════════════════════════════════════════════════════════════╝

cap12_1() {
    header; banner "Protocoale E-mail"
    info "Fluxul unui email:"
    echo -e "  ${W}[Client]${N} --SMTP--> ${W}[MTA Expeditor]${N} --SMTP--> ${W}[MTA Destinatar]${N} --IMAP/POP3--> ${W}[Client]${N}"
    echo ""
    cmd "SMTP (25, 587)"    "trimitere email"
    cmd "IMAP (143, 993)"   "citire (mesaje raman pe server)"
    cmd "POP3 (110, 995)"   "descarca si sterge de pe server"
    echo ""
    info "Componente:"
    cmd "MTA"    "Mail Transfer Agent (Postfix, Sendmail)"
    cmd "MDA"    "Mail Delivery Agent (Dovecot, Procmail)"
    cmd "MUA"    "Mail User Agent (Thunderbird, mutt)"
    echo ""
    info "Port 25 deschis pe acest sistem?"
    run "ss -tln | grep ':25 ' && echo 'SMTP activ!' || echo 'Portul 25 nu este deschis (Postfix probabil nu ruleaza).'"
    pause
}

cap12_2() {
    header; banner "Postfix: Instalare si Configurare"
    info "Postfix = cel mai popular MTA Linux, cunoscut pentru securitate."
    echo ""
    cmd "sudo apt install postfix"      "instaleaza Postfix"
    cmd "systemctl status postfix"      "verifica starea"
    cmd "/etc/postfix/main.cf"          "fisierul de configurare"
    echo ""
    info "Parametri esentiali main.cf:"
    cmd "myhostname"       "FQDN al serverului"
    cmd "mydomain"         "domeniul principal"
    cmd "inet_interfaces"  "interfete de ascultare (all)"
    cmd "mydestination"    "domenii pentru care primeste"
    cmd "mynetworks"       "retele de incredere"
    echo ""
    cmd "postfix check"       "verifica configuratia"
    cmd "postfix reload"      "reincarca config"
    cmd "mailq"               "coada de email"
    echo ""
    run "which postfix 2>/dev/null && echo 'Postfix este instalat' || echo 'Postfix nu este instalat. Instalare: sudo apt install postfix'"
    run "[ -f /etc/postfix/main.cf ] && grep -v '^#' /etc/postfix/main.cf | grep -v '^$' | head -10 || echo 'Config: /etc/postfix/main.cf (fisier inexistent)'"
    pause
}

cap12_3() {
    header; banner "Testare si Monitorizare Email"
    info "Trimitere email de test:"
    cmd "echo 'Mesaj' | mail -s 'Sub' user@host"  "trimite email"
    cmd "mail"                                      "citeste email-uri"
    echo ""
    info "Monitorizare:"
    cmd "tail -f /var/log/mail.log"    "loguri in timp real"
    cmd "journalctl -u postfix -f"     "loguri systemd"
    cmd "mailq"                        "coada de email"
    echo ""
    info "DNS records necesare pt server email profesional:"
    cmd "MX record"   "indica serverul de email"
    cmd "SPF record"  "servere autorizate sa trimita"
    cmd "DKIM"        "semnatura digitala email"
    cmd "DMARC"       "politici pe baza SPF+DKIM"
    echo ""
    run "[ -f /var/log/mail.log ] && sudo tail -5 /var/log/mail.log 2>/dev/null || echo 'Fara loguri mail (Postfix nu este activ).'"
    pause
}

cap12_menu() {
    while true; do
        header; banner "Serverul E-mail"
        echo -e "  ${C}1.${N} Protocoale (SMTP, IMAP, POP3)"
        echo -e "  ${C}2.${N} Postfix: instalare si configurare"
        echo -e "  ${C}3.${N} Testare si monitorizare email"
        echo -e "  ${R}0.${N} Inapoi"
        echo -e "\n  ${C}${S}${N}"
        echo -ne "  Alegeti (0-3): "; read -r o
        case $o in 1)cap12_1;; 2)cap12_2;; 3)cap12_3;; 0)return;; *)invalid;; esac
    done
}

# ╔════════════════════════════════════════════════════════════╗
# ║  CAPITOLUL 13 — SERVERUL NTP                              ║
# ╚════════════════════════════════════════════════════════════╝

cap13_1() {
    header; banner "NTP — Network Time Protocol"
    info "NTP sincronizeaza ceasul computerelor din retea."
    info "Ceasuri nesincronizate cauzeaza: certificate SSL invalide, erori loguri, probleme BD."
    echo ""
    info "Ierarhia Stratum:"
    cmd "Stratum 0"    "ceasuri atomice, GPS"
    cmd "Stratum 1"    "conectat direct la Stratum 0"
    cmd "Stratum 2"    "sincronizat cu Stratum 1"
    echo ""
    info "Servere NTP publice:"
    cmd "pool.ntp.org"          "pool global"
    cmd "0.ro.pool.ntp.org"     "pool Romania"
    cmd "time.google.com"       "Google"
    echo ""
    info "Implementari pe Ubuntu:"
    cmd "systemd-timesyncd"   "client simplu (default)"
    cmd "chrony"              "client + server (recomandat)"
    cmd "ntpd"                "clasic"
    echo ""
    run "timedatectl status"
    pause
}

cap13_2() {
    header; banner "Configurare NTP / Chrony"
    info "systemd-timesyncd (implicit pe Ubuntu):"
    cmd "/etc/systemd/timesyncd.conf"    "fisier config"
    cmd "timedatectl show-timesync"      "starea sincronizarii"
    echo ""
    info "Chrony (mai puternic, si server NTP):"
    cmd "sudo apt install chrony"          "instaleaza"
    cmd "/etc/chrony/chrony.conf"          "fisier config"
    cmd "chronyc sources -v"               "surse NTP active"
    cmd "chronyc tracking"                 "stare sincronizare"
    echo ""
    info "Configuratie server chrony (distribuie timp in LAN):"
    cmd "allow 192.168.1.0/24"    "permite clienti din retea"
    cmd "local stratum 10"        "fallback fara internet"
    echo ""
    run "systemctl is-active systemd-timesyncd 2>/dev/null && echo 'timesyncd: ACTIV' || echo 'timesyncd: inactiv'"
    run "which chronyd 2>/dev/null && chronyc sources 2>/dev/null || echo 'Chrony nu este instalat. Instalare: sudo apt install chrony'"
    pause
}

cap13_3() {
    header; banner "Gestionarea Orei (date, timedatectl, hwclock)"
    cmd "date"                    "ora curenta"
    cmd 'date +"%Y-%m-%d %H:%M"' "format personalizat"
    cmd "timedatectl status"      "stare completa"
    cmd "timedatectl list-timezones" "fusuri orare disponibile"
    cmd "timedatectl set-timezone Europe/Bucharest" "seteaza Romania"
    cmd "timedatectl set-ntp true"   "activeaza NTP"
    cmd "hwclock --show"          "ceasul hardware (RTC)"
    echo ""
    run "timedatectl status"
    run "date '+  Data: %d/%m/%Y  |  Ora: %H:%M:%S  |  Timezone: %Z'"
    run "timedatectl list-timezones | grep -i bucharest"
    pause
}

cap13_menu() {
    while true; do
        header; banner "Serverul NTP"
        echo -e "  ${C}1.${N} Ce este NTP (Stratum, servere publice)"
        echo -e "  ${C}2.${N} Configurare NTP / Chrony"
        echo -e "  ${C}3.${N} Gestionarea orei (date, timedatectl)"
        echo -e "  ${R}0.${N} Inapoi"
        echo -e "\n  ${C}${S}${N}"
        echo -ne "  Alegeti (0-3): "; read -r o
        case $o in 1)cap13_1;; 2)cap13_2;; 3)cap13_3;; 0)return;; *)invalid;; esac
    done
}

# ╔════════════════════════════════════════════════════════════╗
# ║  MENIU PRINCIPAL                                          ║
# ╚════════════════════════════════════════════════════════════╝

main_menu() {
    while true; do
        header
        echo ""
        echo -e "  ${W}${BOLD}Selectati un capitol:${N}"
        echo ""
        echo -e "  ${C}1.${N} Sistemul de Fisiere           ${DIM}(navigare, permisiuni, arhivare)${N}"
        echo -e "  ${C}2.${N} Utilizatori si Permisiuni     ${DIM}(useradd, passwd, grupuri)${N}"
        echo -e "  ${C}3.${N} Procese si Semnale            ${DIM}(ps, kill, bg/fg, systemd)${N}"
        echo -e "  ${C}4.${N} Shell Scripting               ${DIM}(variabile, bucle, functii)${N}"
        echo -e "  ${C}5.${N} Administrarea Software-ului   ${DIM}(apt, dpkg, hardware)${N}"
        echo -e "  ${C}6.${N} Configurarea Retelei          ${DIM}(ip, ping, dns, porturi)${N}"
        echo -e "  ${C}7.${N} Serverul E-mail               ${DIM}(Postfix, SMTP, IMAP)${N}"
        echo -e "  ${C}8.${N} Serverul NTP                  ${DIM}(chrony, timedatectl)${N}"
        echo ""
        echo -e "  ${R}0.${N} IESIRE"
        echo ""
        echo -e "  ${C}${S}${N}"
        echo -ne "  Selectati capitolul (0-8): "
        read -r opt
        case $opt in
            1) cap3_menu  ;;
            2) cap4_menu  ;;
            3) cap5_menu  ;;
            4) cap6_menu  ;;
            5) cap7_menu  ;;
            6) cap8_menu  ;;
            7) cap12_menu ;;
            8) cap13_menu ;;
            0)
                clear
                echo -e "${C}╔${L}╗${N}"
                echo -e "${C}║${W}${BOLD}       La revedere! Spor la invatat Linux!                    ${N}${C}║${N}"
                echo -e "${C}╠${L}╣${N}"
                echo -e "${C}║${Y}  IACOB COSTEL  |  Anul I ID  |  Grupa 106                   ${N}${C}║${N}"
                echo -e "${C}╚${L}╝${N}"
                echo ""
                exit 0
                ;;
            *) invalid ;;
        esac
    done
}

# ── Start ─────────────────────────────────────────────────────
main_menu
