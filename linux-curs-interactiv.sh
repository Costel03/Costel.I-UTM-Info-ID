#!/bin/bash
# ╔══════════════════════════════════════════════════════════════════╗
# ║       LABORATOR LINUX — CURS INTERACTIV  v2.0                  ║
# ║──────────────────────────────────────────────────────────────────║
# ║  Student : IACOB COSTEL                                        ║
# ║  Anul I ID | Grupa 106                                         ║
# ║  Capitole: 3,4,5,6,7,8,12,13 (InfoAcademy)                    ║
# ╚══════════════════════════════════════════════════════════════════╝

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  CULORI & STILURI
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
R='\033[0;31m';   BR='\033[1;31m'
G='\033[0;32m';   BG='\033[1;32m'
Y='\033[1;33m';   BY='\033[0;33m'
C='\033[0;36m';   BC='\033[1;36m'
B='\033[1;34m';   BL='\033[0;34m'
M='\033[0;35m';   BM='\033[1;35m'
W='\033[1;37m';   GR='\033[0;37m'
BOLD='\033[1m';   DIM='\033[2m';   ITAL='\033[3m';  UL='\033[4m'
INV='\033[7m';    N='\033[0m'
BG_HEADER='\033[48;5;17m'      # fundo albastru inchis
BG_WARN='\033[48;5;52m'        # fundo rosu inchis
BG_OK='\033[48;5;22m'          # fundo verde inchis
BG_CMD='\033[48;5;234m'        # fundo gri foarte inchis
BG_TIP='\033[48;5;58m'         # fundo galben inchis

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  CONSTANTE
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
DEMO_DIR="/tmp/.linux_curs_$$"
trap 'rm -rf "$DEMO_DIR" 2>/dev/null' EXIT
mkdir -p "$DEMO_DIR"

L="══════════════════════════════════════════════════════════════════"
S="──────────────────────────────────────────────────────────────────"
D="░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  FUNCTII DE AFISARE
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

header() {
    clear
    local w=66
    echo -e "${BC}╔${L}╗${N}"
    printf "${BC}║${BG_HEADER}${W}${BOLD}%*s%-*s${N}${BC}║${N}\n" 4 "" $((w-4)) "  ▶  LABORATOR LINUX — CURS INTERACTIV  ◀"
    echo -e "${BC}╠${L}╣${N}"
    printf "${BC}║${N}${DIM}  %-64s${BC}║${N}\n" "  Costel Iacob  │  Anul I ID  │  Grupa 106  │  v2.0"
    echo -e "${BC}╚${L}╝${N}"
}

banner() {
    local text="$1"
    local icon="${2:-◆}"
    echo ""
    echo -e "  ${BC}┌${S}┐${N}"
    printf "  ${BC}│${N} ${BM}${BOLD}${icon} %-62s${N}${BC}│${N}\n" "$text"
    echo -e "  ${BC}└${S}┘${N}"
    echo ""
}

# Badge colorat mic pentru tipul de info
badge() {
    case "$1" in
        DOC)   printf "${BG_CMD}${C}${BOLD} ℹ DOC ${N} ";;
        CMD)   printf "${BG_CMD}${Y}${BOLD} \$ CMD ${N} ";;
        TIP)   printf "${BG_TIP}${BY}${BOLD} ★ TIP ${N} ";;
        WARN)  printf "${BG_WARN}${BR}${BOLD} ⚠ ATN ${N} ";;
        OK)    printf "${BG_OK}${BG}${BOLD} ✔ OK  ${N} ";;
        EX)    printf "${BG_CMD}${M}${BOLD} ▶ EX  ${N} ";;
    esac
}

info()  { echo -e "  $(badge DOC)${N} ${GR}$1${N}"; }
tip()   { echo -e "  $(badge TIP)${N} ${BY}${ITAL}$1${N}"; }
warn()  { echo -e "  $(badge WARN)${N} ${BR}$1${N}"; }
ok()    { echo -e "  $(badge OK)${N} ${BG}$1${N}"; }

# Afiseaza o comanda cu descriere
cmd() {
    printf "  ${BG_CMD}  ${Y}${BOLD}%-36s${N}${BG_CMD}${DIM}  # %-26s${N}\n" "$1" "$2"
}

# Ruleaza o comanda si afiseaza output-ul frumos
run() {
    local command="$1"
    echo ""
    echo -e "  ${BC}╭─ ${Y}${BOLD}\$ ${command}${N}"
    echo -e "  ${BC}│${N}"
    eval "$command" 2>&1 | while IFS= read -r line; do
        printf "  ${BC}│${N}  %s\n" "$line"
    done
    local rc=${PIPESTATUS[0]}
    echo -e "  ${BC}│${N}"
    if [[ $rc -eq 0 ]]; then
        echo -e "  ${BC}╰─ ${BG}✔ exit 0${N}"
    else
        echo -e "  ${BC}╰─ ${BR}✘ exit $rc${N}"
    fi
    echo ""
}

# Intreaba daca sa ruleze comanda
ask_run() {
    local command="$1"
    echo -ne "  ${G}▶${N} Rulam ${Y}${BOLD}${command}${N} ? ${DIM}[D/n]${N} "
    read -r ans
    ans=${ans:-d}
    if [[ "${ans,,}" =~ ^(d|y|da|yes)$ ]]; then
        run "$command"
    else
        echo -e "  ${DIM}  ↩ sarit${N}\n"
    fi
}

pause() {
    echo ""
    echo -e "  ${DIM}${S}${N}"
    echo -ne "  ${BC}►${N} ${DIM}Apasati ENTER pentru a continua...${N} "
    read -r
}

invalid() { echo -e "\n  ${BR}✘ Optiune invalida!${N}"; sleep 0.6; }

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  SANDBOX — TERMINAL INTERACTIV
#  Utilizatorul poate tasta orice comanda; rezultatul e afisat live.
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Comenzi blocate (potential periculoase in context educational)
_BLOCKED_CMDS=(
    "rm -rf /"   "rm -rf /*"   "dd if=/dev/zero"
    "mkfs"       ":(){:|:&};:" "chmod -R 777 /"
    "fork bomb"  "shutdown"    "reboot"
)

_is_dangerous() {
    local input="$1"
    for blocked in "${_BLOCKED_CMDS[@]}"; do
        if [[ "$input" == *"$blocked"* ]]; then
            return 0
        fi
    done
    return 1
}

sandbox() {
    header
    banner "Terminal Sandbox — Tastati Orice Comanda" "▶"
    info "Introduceti comenzi Linux si vedeti rezultatul imediat."
    info "Tastati ${Y}exit${N}${GR} sau ${Y}q${N}${GR} pentru a iesi."
    tip  "Toate comenzile ruleaza in directorul curent al scriptului."
    echo ""
    echo -e "  ${DIM}${D}${N}"
    echo ""

    local history_file="$DEMO_DIR/sandbox_history"
    touch "$history_file"
    local cmd_count=0

    while true; do
        echo -ne "  ${BM}[sandbox]${N} ${Y}${BOLD}\$${N} "
        read -r user_cmd

        [[ -z "$user_cmd" ]] && continue
        [[ "$user_cmd" == "exit" || "$user_cmd" == "q" || "$user_cmd" == "quit" ]] && break

        if _is_dangerous "$user_cmd"; then
            warn "Comanda blocata din motive de siguranta!"
            echo -e "  ${DIM}  Aceasta este o sesiune educationala.${N}"
            echo ""
            continue
        fi

        echo "$user_cmd" >> "$history_file"
        cmd_count=$((cmd_count + 1))

        echo ""
        echo -e "  ${BC}╭─ ${Y}${BOLD}\$ ${user_cmd}${N}"
        echo -e "  ${BC}│${N}"
        (eval "$user_cmd" 2>&1) | while IFS= read -r line; do
            printf "  ${BC}│${N}  %s\n" "$line"
        done
        local rc=${PIPESTATUS[0]}
        echo -e "  ${BC}│${N}"
        if [[ $rc -eq 0 ]]; then
            echo -e "  ${BC}╰─ ${BG}✔ exit 0${N}"
        else
            echo -e "  ${BC}╰─ ${BR}✘ exit $rc${N}"
        fi
        echo ""
    done

    echo ""
    echo -e "  ${BG}✔${N} ${DIM}Iesit din sandbox dupa ${cmd_count} comenzi.${N}"
    sleep 0.8
}

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  RUNNER DE EXEMPLE — utilizatorul alege un exemplu din lista
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Apelat cu: examples_menu "Titlu sectiune" cmd1 "desc1" cmd2 "desc2" ...
# Primeste o lista de perechi (cmd, desc) si permite selectia si rularea.
examples_menu() {
    local title="$1"; shift
    local -a cmds=()
    local -a descs=()
    while [[ $# -ge 2 ]]; do
        cmds+=("$1")
        descs+=("$2")
        shift 2
    done

    while true; do
        echo ""
        echo -e "  ${BC}┌── ${BM}Exemple: ${W}${title}${N}"
        local i=1
        for ((idx=0; idx<${#cmds[@]}; idx++)); do
            printf "  ${BC}│${N}  ${C}%-3s${N} ${Y}${BOLD}%-38s${N} ${DIM}%s${N}\n" \
                   "${i}." "${cmds[$idx]}" "${descs[$idx]}"
            i=$((i+1))
        done
        echo -e "  ${BC}│${N}  ${BM}a.${N}  Ruleaza TOATE exemplele"
        echo -e "  ${BC}│${N}  ${M}s.${N}  Sandbox — tastez propria comanda"
        echo -e "  ${BC}│${N}  ${R}0.${N}  Inapoi"
        echo -e "  ${BC}└${S}┘${N}"
        echo -ne "  Alegeti exemplul (0-${#cmds[@]}/a/s): "
        read -r choice

        case "$choice" in
            0) return ;;
            a|A)
                for ((idx=0; idx<${#cmds[@]}; idx++)); do
                    run "${cmds[$idx]}"
                done
                pause
                ;;
            s|S)
                sandbox
                ;;
            ''|*[!0-9]*)
                invalid ;;
            *)
                local num=$((choice-1))
                if [[ $num -ge 0 && $num -lt ${#cmds[@]} ]]; then
                    run "${cmds[$num]}"
                    echo -ne "  ${DIM}Apasati ENTER...${N} "; read -r
                else
                    invalid
                fi
                ;;
        esac
    done
}

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  CAP 3 — SISTEMUL DE FISIERE
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

cap3_1() {
    header; banner "Structura Sistemului de Fisiere (FHS)" "📁"

    info "Linux organizeaza totul intr-un singur arbore ierarhic care porneste din '/' (root)."
    info "Spre deosebire de Windows, nu exista litere de drive (C:, D:). Totul este sub /."
    echo ""
    info "Directoarele standard principale (Filesystem Hierarchy Standard):"
    echo ""
    cmd "/home"      "directoarele personale ale utilizatorilor"
    cmd "/etc"       "fisiere de configurare sistem"
    cmd "/var"       "date variabile: loguri, cozi de asteptare, baze de date"
    cmd "/tmp"       "fisiere temporare (sterge la reboot)"
    cmd "/bin /sbin" "comenzi esentiale pentru sistem (ls, cp, ip)"
    cmd "/usr"       "software instalat de utilizator"
    cmd "/lib"       "biblioteci partajate (.so)"
    cmd "/proc"      "pseudo-filesystem: informatii despre procese si kernel"
    cmd "/dev"       "fisiere-dispozitiv (HDD, USB, terminal)"
    cmd "/mnt /media" "puncte de montare pentru discuri externe"
    echo ""
    tip "Comanda 'man hier' explica intreaga ierarhie FHS."
    echo ""
    examples_menu "Structura FHS" \
        "ls -lah /"                          "afiseaza radacina sistemului" \
        "df -Th | head -15"                  "sisteme de fisiere montate si tipurile lor" \
        "du -sh /etc /var /home 2>/dev/null" "spatiu folosit de directoare cheie" \
        "ls /proc | head -30"                "continutul pseudo-fs /proc"
}

cap3_2() {
    header; banner "Navigare: pwd, ls, cd" "🧭"

    info "Aceste trei comenzi sunt fundamentul oricarei sesiuni in terminal."
    echo ""
    cmd "pwd"              "Print Working Directory — afiseaza calea completa curenta"
    cmd "ls"               "LiSt — afiseaza continutul unui director"
    cmd "ls -l"            "format lung: permisiuni, proprietar, marime, data"
    cmd "ls -la"           "include fisierele ascunse (incep cu '.')"
    cmd "ls -lh"           "marimi in format human-readable (K, M, G)"
    cmd "ls --color=auto"  "colorizeaza tipurile de fisiere"
    cmd "cd /cale"         "Change Directory — navigheaza la o cale absoluta"
    cmd "cd ~"             "merg la directorul home (/home/user)"
    cmd "cd .."            "un nivel mai sus in ierarhie"
    cmd "cd -"             "inapoi la directorul anterior (toggle)"
    echo ""
    tip "Folositi TAB pentru auto-complete al numelor de fisiere si directoare!"
    tip "Calea '.' = directorul curent. Calea '..' = parintele sau."
    echo ""
    examples_menu "Navigare" \
        "pwd"                       "directorul curent" \
        "ls -lah ~"                 "continutul home cu fisiere ascunse" \
        "ls -lah /etc | head -20"   "primele 20 intrari din /etc" \
        "ls -lSh /var/log 2>/dev/null | head -15" "fisierele de log sortate dupa marime"
}

cap3_3() {
    header; banner "Operatii cu Fisiere: touch, mkdir, cp, mv, rm" "📝"

    info "Comenzile fundamentale pentru crearea, mutarea si stergerea fisierelor."
    echo ""
    cmd "touch fisier.txt"          "creeaza fisier gol sau actualizeaza timestamp-ul"
    cmd "mkdir director"            "creeaza un director"
    cmd "mkdir -p a/b/c"            "creeaza ierarhie de directoare (nu da eroare daca exista)"
    cmd "cp sursa dest"             "copiaza un fisier"
    cmd "cp -r dir1/ dir2/"         "copiaza un director recursiv"
    cmd "cp -p fisier bk"           "copiaza pastrând permisiunile si timestampul"
    cmd "mv vechi nou"              "redenumeste sau muta fisier/director"
    cmd "rm fisier"                 "sterge un fisier (ireversibil!)"
    cmd "rm -rf director/"          "sterge director si tot continutul sau"
    cmd "cat fisier"                "afiseaza intreg continutul unui fisier"
    cmd "head -10 fisier"           "primele 10 linii"
    cmd "tail -10 fisier"           "ultimele 10 linii"
    cmd "tail -f /var/log/syslog"   "urmareste loguri live (Ctrl+C pentru iesire)"
    echo ""
    warn "rm -rf nu are cos de gunoi! Odata sters, fisierul este pierdut."
    tip  "Folositi 'cp -r' inainte sa stergeti ceva important, ca backup."
    echo ""
    mkdir -p "$DEMO_DIR/proiect/src" "$DEMO_DIR/proiect/docs"
    echo "# Proiect Demo Linux" > "$DEMO_DIR/proiect/readme.md"
    echo "print('Hello World')" > "$DEMO_DIR/proiect/src/main.py"
    echo "Documentatie" > "$DEMO_DIR/proiect/docs/doc.txt"
    examples_menu "Fisiere si Directoare" \
        "ls -la $DEMO_DIR/proiect/"                                  "structura proiectului demo" \
        "cat $DEMO_DIR/proiect/readme.md"                            "afiseaza fisierul readme" \
        "cp $DEMO_DIR/proiect/readme.md $DEMO_DIR/proiect/readme.bk && ls $DEMO_DIR/proiect/" \
                                                                     "copiaza fisier, listeaza" \
        "find $DEMO_DIR/proiect -type f"                             "gaseste toate fisierele recursiv" \
        "wc -l $DEMO_DIR/proiect/docs/doc.txt"                      "numara linii"
}

cap3_4() {
    header; banner "Permisiuni: chmod, chown (rwx / octal)" "🔐"

    info "Fiecare fisier are 3 seturi de permisiuni: proprietar(u), grup(g), altii(o)."
    info "Tipuri de permisiuni: r=citire(4)  w=scriere(2)  x=executie(1)"
    echo ""
    info "Combinatii octal frecvente:"
    cmd "755 → rwxr-xr-x"   "executabil/script: proprietar poate tot, restul citesc+executa"
    cmd "644 → rw-r--r--"   "fisier text: proprietar citeste+scrie, restul citesc"
    cmd "700 → rwx------"   "acces exclusiv proprietar (chei SSH private)"
    cmd "600 → rw-------"   "fisier privat: proprietar citeste+scrie"
    cmd "777 → rwxrwxrwx"   "permisiuni totale pt toti (evitati!)"
    echo ""
    cmd "chmod 755 script.sh"      "seteaza permisiuni in octal"
    cmd "chmod u+x script.sh"      "adauga bit de executie pentru proprietar"
    cmd "chmod -R 755 dir/"        "aplica recursiv unui director"
    cmd "chown user:grup fisier"   "schimba proprietarul si grupul"
    cmd "chown -R user: dir/"      "recursiv, pastreaza grupul"
    cmd "umask 022"                "masca implicita la creare fisiere"
    echo ""
    tip  "Cititi permisiunile cu 'stat fisier' pentru format detaliat."
    warn "Nu setati 777 pe fisiere server-side — oricine poate modifica/executa."
    echo ""
    mkdir -p "$DEMO_DIR"
    echo '#!/bin/bash
echo "Script executat cu succes de $USER!"' > "$DEMO_DIR/demo.sh"
    examples_menu "Permisiuni" \
        "ls -la /etc/passwd /etc/shadow 2>/dev/null || ls -la /etc/passwd" \
                                                   "/etc/shadow are permisiuni restrictive" \
        "ls -l $DEMO_DIR/demo.sh"                  "permisiunile initiale ale scriptului" \
        "chmod 755 $DEMO_DIR/demo.sh && ls -l $DEMO_DIR/demo.sh" \
                                                   "adaugam drept de executie" \
        "$DEMO_DIR/demo.sh"                        "rulam scriptul" \
        "stat $DEMO_DIR/demo.sh"                   "informatii complete despre fisier"
}

cap3_5() {
    header; banner "Cautare: find, locate, grep, which" "🔍"

    info "Linux ofera unelte puternice pentru gasirea fisierelor si continutului lor."
    echo ""
    cmd "find /cale -name 'pattern'"   "cauta dupa numele fisierului"
    cmd "find / -size +100M"           "fisiere mai mari de 100MB"
    cmd "find . -mtime -1"             "fisiere modificate in ultimele 24h"
    cmd "find . -type d"               "doar directoare"
    cmd "find . -type f -perm 777"     "fisiere cu permisiuni 777"
    cmd "grep 'text' fisier"           "cauta un text in fisier"
    cmd "grep -r 'text' /etc/"         "recursiv intr-un director"
    cmd "grep -i 'text' fisier"        "case-insensitive"
    cmd "grep -n 'text' fisier"        "afiseaza si numarul liniei"
    cmd "grep -v 'text' fisier"        "inversare — linii care NU contin textul"
    cmd "which comanda"                "calea absoluta a unui executabil"
    cmd "whereis comanda"              "binar + manual + sursa"
    echo ""
    tip "Combinati find cu exec: find . -name '*.log' -exec rm {} \\;"
    echo ""
    examples_menu "Cautare" \
        "find /etc -maxdepth 1 -name '*.conf' 2>/dev/null | head -12" \
                                                    "fisiere .conf din /etc" \
        "which bash python3 ls grep 2>/dev/null"    "caile executabilelor" \
        "grep -r 'localhost' /etc/hosts"            "cauta localhost in /etc/hosts" \
        "find /tmp -type f -newer /etc/hosts 2>/dev/null | head -10" \
                                                    "fisiere create mai recent decat /etc/hosts" \
        "grep -c '' /etc/passwd && echo linii in /etc/passwd" \
                                                    "numara linii in /etc/passwd"
}

cap3_6() {
    header; banner "Arhivare: tar, gzip, zip" "📦"

    info "tar grupeaza mai multe fisiere intr-unul singur (nu comprima de sine statator)."
    info "gzip/bzip2/xz adauga compresie. De obicei se combina: tar + gzip = .tar.gz"
    echo ""
    cmd "tar -czvf arhiva.tar.gz dir/"   "creeaza arhiva cu compresie gzip"
    cmd "tar -xzvf arhiva.tar.gz"        "dezarhiveaza in directorul curent"
    cmd "tar -tzvf arhiva.tar.gz"        "listeaza continutul fara a extrage"
    cmd "tar -xzvf arhiva.tar.gz -C /dest/" "extrage intr-un director specificat"
    cmd "gzip fisier"                    "comprima (creeaza fisier.gz)"
    cmd "gunzip fisier.gz"               "decomprima"
    cmd "zip -r arhiva.zip dir/"         "format ZIP"
    cmd "unzip arhiva.zip"               "extrage ZIP"
    echo ""
    info "Memotehnic tar: ${BOLD}c${N}${GR}reate ${BOLD}x${N}${GR}tract lis${BOLD}t${N}${GR} | ${BOLD}z${N}${GR}=gzip ${BOLD}j${N}${GR}=bzip2 | ${BOLD}v${N}${GR}erbose ${BOLD}f${N}${GR}ile"
    tip  "Folositi bzip2 (-j) sau xz (-J) pentru compresie mai buna (dar mai lenta)."
    echo ""
    mkdir -p "$DEMO_DIR/arhivare"
    echo "Fisier 1" > "$DEMO_DIR/arhivare/a.txt"
    echo "Fisier 2" > "$DEMO_DIR/arhivare/b.txt"
    examples_menu "Arhivare" \
        "tar -czvf $DEMO_DIR/demo.tar.gz /etc/hosts /etc/hostname 2>/dev/null && echo Creat!" \
                                                           "creeaza arhiva cu 2 fisiere" \
        "ls -lh $DEMO_DIR/demo.tar.gz"                     "marimea arhivei" \
        "tar -tzvf $DEMO_DIR/demo.tar.gz"                  "listeaza continutul" \
        "tar -xzvf $DEMO_DIR/demo.tar.gz -C $DEMO_DIR/ 2>/dev/null && echo Extras!" \
                                                           "extrage arhiva" \
        "gzip -v $DEMO_DIR/arhivare/a.txt && ls -lh $DEMO_DIR/arhivare/" \
                                                           "comprima un fisier cu gzip"
}

cap3_menu() {
    while true; do
        header; banner "Capitolul 3 — Sistemul de Fisiere" "📁"
        echo -e "  ${C}1.${N} Structura FHS         ${DIM}(/, /home, /etc, /var, /proc)${N}"
        echo -e "  ${C}2.${N} Navigare              ${DIM}(pwd, ls, cd)${N}"
        echo -e "  ${C}3.${N} Operatii fisiere      ${DIM}(touch, mkdir, cp, mv, rm)${N}"
        echo -e "  ${C}4.${N} Permisiuni            ${DIM}(chmod, chown, octal rwx)${N}"
        echo -e "  ${C}5.${N} Cautare               ${DIM}(find, grep, which, whereis)${N}"
        echo -e "  ${C}6.${N} Arhivare              ${DIM}(tar, gzip, zip)${N}"
        echo -e "  ${M}s.${N} Sandbox Terminal      ${DIM}(tasteaza orice comanda)${N}"
        echo -e "  ${R}0.${N} Inapoi"
        echo ""
        echo -e "  ${BC}${S}${N}"
        echo -ne "  Alegeti (0-6/s): "; read -r o
        case $o in
            1)cap3_1;; 2)cap3_2;; 3)cap3_3;; 4)cap3_4;; 5)cap3_5;; 6)cap3_6;;
            s|S)sandbox;; 0)return;; *)invalid;;
        esac
    done
}

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  CAP 4 — UTILIZATORI SI PERMISIUNI
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

cap4_1() {
    header; banner "Informatii despre Utilizatori" "👤"

    info "In Linux, fiecare utilizator are un identificator unic (UID) si un grup primar (GID)."
    info "Structura fisierului /etc/passwd:  user:x:UID:GID:Comentariu:Home:Shell"
    echo ""
    cmd "whoami"         "afiseaza utilizatorul curent"
    cmd "id"             "UID, GID si toate grupurile"
    cmd "who"            "utilizatorii conectati la sistem"
    cmd "w"              "utilizatorii activi + ce fac"
    cmd "last"           "istoricul autentificarilor"
    cmd "lastlog"        "ultima conectare a fiecarui user"
    echo ""
    tip  "UID 0 = root (superuser). UID 1-999 = conturi de sistem. UID 1000+ = utilizatori normali."
    echo ""
    examples_menu "Info Utilizatori" \
        "whoami"                              "utilizatorul curent" \
        "id"                                  "UID, GID si grupuri" \
        "head -5 /etc/passwd"                 "primele 5 intrari din /etc/passwd" \
        "w 2>/dev/null || who"               "utilizatori activi" \
        "grep -v 'nologin\|false' /etc/passwd | cut -d: -f1,3,6,7" \
                                              "useri cu shell interactiv"
}

cap4_2() {
    header; banner "Crearea Utilizatorilor (useradd / adduser)" "➕"

    info "useradd este comanda de nivel scazut; adduser este mai prietenos (script interactiv)."
    echo ""
    cmd "useradd -m user"              "creeaza user cu home directory"
    cmd "useradd -m -s /bin/bash user" "specifica shell-ul"
    cmd "useradd -m -G sudo,dev user"  "adauga in grupuri suplimentare"
    cmd "useradd -m -c 'Nume Complet' user" "cu comentariu/GECOS"
    cmd "adduser user"                 "mod interactiv (recomandat pe Debian/Ubuntu)"
    cmd "passwd user"                  "seteaza sau schimba parola"
    cmd "passwd -e user"               "expira parola (user trebuie s-o schimbe la login)"
    echo ""
    tip  "adduser creeaza automat home, copiaza /etc/skel si seteaza permisiunile."
    warn "Dupa useradd, nu uitati sa setati o parola cu passwd!"
    echo ""
    examples_menu "Creare Utilizatori" \
        "grep -v 'nologin\|false' /etc/passwd | cut -d: -f1"  "useri cu shell interactiv" \
        "ls -la /home/"                                        "directoarele home existente" \
        "cat /etc/skel/.bashrc 2>/dev/null | head -10"         "fisierele template din /etc/skel" \
        "id root"                                              "contul root (UID=0)"
}

cap4_3() {
    header; banner "Modificarea Utilizatorilor (usermod)" "✏️"

    info "usermod modifica atributele unui cont existent."
    echo ""
    cmd "usermod -aG sudo user"     "adauga in grup — OBLIGATORIU cu -a (append)!"
    cmd "usermod -s /bin/zsh user"  "schimba shell-ul"
    cmd "usermod -d /home/nou -m"   "schimba home si muta continutul"
    cmd "usermod -L user"           "Lock — blocheaza contul"
    cmd "usermod -U user"           "Unlock — deblocheaza contul"
    cmd "usermod -e 2026-12-31 u"   "seteaza data de expirare a contului"
    cmd "usermod -c 'Nume Nou' user" "modifica campul GECOS (comentariu)"
    echo ""
    cmd "chage -l user"             "afiseaza politica de expirare a parolei"
    cmd "chage -M 90 user"          "parola expira la 90 de zile"
    cmd "chage -W 7 user"           "avertizare cu 7 zile inainte de expirare"
    echo ""
    warn "Fara -a la usermod -G, grupurile existente sunt INLOCUITE, nu adaugate!"
    echo ""
    examples_menu "Modificare Utilizatori" \
        "chage -l $(whoami) 2>/dev/null || echo 'chage necesita root'" \
                                       "politica de parola a contului curent" \
        "grep ^$(whoami) /etc/passwd"  "intrarea din /etc/passwd" \
        "groups $(whoami)"             "grupurile utilizatorului curent" \
        "getent passwd $(whoami)"      "informatii complete (sursa NSS)"
}

cap4_4() {
    header; banner "Stergerea Utilizatorilor (userdel)" "🗑️"

    info "Inainte de a sterge un user, verificati ce fisiere detine si opriti sesiunile active."
    echo ""
    cmd "userdel user"       "sterge contul (pastreaza /home)"
    cmd "userdel -r user"    "sterge contul SI directorul home"
    cmd "pkill -u user"      "opreste toate procesele utilizatorului"
    cmd "find / -user user"  "gaseste fisierele detinute de user"
    echo ""
    tip  "Dupa stergere, fisierele fara proprietar raman cu UID numeric (orfane)."
    tip  "Alternativ, puteti bloca contul cu usermod -L in loc sa il stergeti."
    echo ""
    examples_menu "Stergere Utilizatori" \
        "find /tmp -maxdepth 2 -nouser 2>/dev/null | head -5 || echo 'Niciun fisier orfan in /tmp'" \
                                        "fisiere fara proprietar" \
        "ls -la /home/"                 "directoarele home curente" \
        "who"                           "utilizatori conectati acum"
}

cap4_5() {
    header; banner "Gestionarea Grupurilor" "👥"

    info "Grupurile permit acordarea de permisiuni comune mai multor utilizatori."
    echo ""
    cmd "groups"                     "grupurile utilizatorului curent"
    cmd "groupadd proiect"           "creeaza un grup nou"
    cmd "groupmod -n nou vechi"      "redenumeste un grup"
    cmd "groupdel grup"              "sterge un grup"
    cmd "usermod -aG grup user"      "adauga user la grup (cu -a!)"
    cmd "gpasswd -d user grup"       "elimina userul din grup"
    cmd "newgrp grup"                "schimba grupul primar al sesiunii curente"
    echo ""
    tip "Modificarile de grup se aplica la urmatoarea autentificare. Sau: newgrp grup"
    echo ""
    examples_menu "Grupuri" \
        "groups $(whoami)"       "grupurile mele" \
        "tail -15 /etc/group"    "ultimele grupuri definite" \
        "id"                     "UID, GID si toate grupurile" \
        "getent group sudo 2>/dev/null || grep '^sudo:' /etc/group" \
                                 "membrii grupului sudo"
}

cap4_menu() {
    while true; do
        header; banner "Capitolul 4 — Utilizatori si Permisiuni" "👤"
        echo -e "  ${C}1.${N} Informatii utilizatori   ${DIM}(whoami, id, /etc/passwd)${N}"
        echo -e "  ${C}2.${N} Crearea utilizatorilor   ${DIM}(useradd, adduser, passwd)${N}"
        echo -e "  ${C}3.${N} Modificarea utilizatorilor ${DIM}(usermod, chage)${N}"
        echo -e "  ${C}4.${N} Stergerea utilizatorilor ${DIM}(userdel)${N}"
        echo -e "  ${C}5.${N} Gestionarea grupurilor   ${DIM}(groupadd, usermod -aG)${N}"
        echo -e "  ${M}s.${N} Sandbox Terminal          ${DIM}(tasteaza orice comanda)${N}"
        echo -e "  ${R}0.${N} Inapoi"
        echo ""
        echo -e "  ${BC}${S}${N}"
        echo -ne "  Alegeti (0-5/s): "; read -r o
        case $o in
            1)cap4_1;; 2)cap4_2;; 3)cap4_3;; 4)cap4_4;; 5)cap4_5;;
            s|S)sandbox;; 0)return;; *)invalid;;
        esac
    done
}

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  CAP 5 — PROCESE SI SEMNALE
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

cap5_1() {
    header; banner "Afisarea si Monitorizarea Proceselor" "⚙️"

    info "Un proces = un program in executie, cu un PID unic (Process ID)."
    info "PID 1 (systemd sau init) este parintele tuturor proceselor."
    echo ""
    cmd "ps aux"              "afiseaza TOATE procesele (format BSD)"
    cmd "ps -ef"              "afiseaza TOATE procesele (format UNIX)"
    cmd "ps aux | grep nginx" "filtreaza dupa numele procesului"
    cmd "ps -eo pid,ni,comm"  "coloane personalizate: PID, nice, comanda"
    cmd "top"                 "monitor interactiv (q=iesire, k=kill, r=renice)"
    cmd "htop"                "top imbunatatit cu interfata vizuala"
    cmd "pstree"              "arbore ierarhic de procese"
    cmd "pstree -p"           "cu PID-urile afisate"
    echo ""
    info "Coloane ps aux: USER  PID  %CPU  %MEM  VSZ  RSS  STAT  COMMAND"
    info "Stari STAT: R=running  S=sleeping  Z=zombie  T=stopped  D=I/O wait"
    tip  "Procesele zombie au parintele care nu a colectat exit code-ul (wait())."
    echo ""
    examples_menu "Monitorizare Procese" \
        "ps aux --sort=-%cpu | head -12"          "top 12 procese dupa CPU" \
        "ps aux --sort=-%mem | head -12"          "top 12 procese dupa memorie" \
        "pstree -p | head -25"                    "arbore de procese" \
        "ps -eo pid,ppid,user,stat,comm | head -20" "cu parintele (PPID)" \
        "ls /proc | grep -E '^[0-9]+$' | wc -l"  "numarul total de procese active"
}

cap5_2() {
    header; banner "Background / Foreground / Jobs" "🔄"

    info "Terminalul poate rula mai multe procese simultan prin job control."
    echo ""
    cmd "comanda &"      "porneste comanda in background"
    cmd "Ctrl+Z"         "suspenda procesul din foreground"
    cmd "bg"             "continua procesul suspendat in background"
    cmd "bg %2"          "continua job-ul numarul 2"
    cmd "fg"             "aduce ultimul job in foreground"
    cmd "fg %2"          "aduce job-ul 2 in foreground"
    cmd "jobs -l"        "listeaza toate job-urile cu PID-urile"
    cmd "nohup cmd &"    "ruleaza si supravietuieste la logout (SIGHUP)"
    cmd "disown %1"      "detaseaza job-ul 1 de terminal"
    echo ""
    tip "nohup redirectioneaza output-ul in nohup.out (in directorul curent)."
    echo ""
    examples_menu "Jobs" \
        "sleep 60 & echo \"PID: \$!\" && jobs -l && kill %1 2>/dev/null && echo 'Job oprit'" \
                                         "porneste, verifica si opreste un job" \
        "for i in 1 2 3; do sleep 5 & done; jobs -l; kill \$(jobs -p); echo Done" \
                                         "mai multe job-uri in background" \
        "jobs -l"                        "job-urile curente"
}

cap5_3() {
    header; banner "Semnale: kill, killall, pkill" "📡"

    info "Semnalele sunt mesaje trimise proceselor pentru a le controla comportamentul."
    echo ""
    cmd "SIGHUP  (1)"    "reload configuratie / terminare la logout"
    cmd "SIGINT  (2)"    "intrerupe (Ctrl+C)"
    cmd "SIGQUIT (3)"    "quit cu core dump"
    cmd "SIGKILL (9)"    "terminare fortata — NU poate fi interceptat sau ignorat!"
    cmd "SIGTERM (15)"   "terminare eleganta (default pentru kill)"
    cmd "SIGCONT (18)"   "continua un proces suspendat"
    cmd "SIGSTOP (19)"   "suspenda — NU poate fi interceptat"
    echo ""
    cmd "kill PID"           "trimite SIGTERM procesului cu PID"
    cmd "kill -9 PID"        "SIGKILL — procesul nu poate rezista"
    cmd "kill -HUP PID"      "SIGHUP — reload config (Nginx, Apache)"
    cmd "killall firefox"    "opreste toate procesele cu acest nume"
    cmd "pkill -u user"      "opreste toate procesele unui utilizator"
    cmd "pkill -f 'python'"  "cauta in linia de comanda completa"
    echo ""
    tip  "Incercati intai SIGTERM. Folositi SIGKILL doar daca procesul nu raspunde."
    warn "SIGKILL nu permite procesului sa elibereze resurse (fisiere deschise, locks)."
    echo ""
    examples_menu "Semnale" \
        "kill -l"                  "lista tuturor semnalelor" \
        "sleep 120 & PID=\$!; echo \"Pornit PID=\$PID\"; kill \$PID; wait \$PID 2>/dev/null; echo Terminat" \
                                   "porneste si trimite SIGTERM" \
        "ps aux | grep sleep | grep -v grep" \
                                   "gaseste procese sleep" \
        "kill -l | tr ' ' '\n' | head -20" \
                                   "semnalele listate vertical"
}

cap5_4() {
    header; banner "Prioritati: nice, renice" "⚖️"

    info "Prioritatea nice controleaza cat timp CPU primeste un proces."
    info "Scala nice: de la -20 (prioritate maxima) la +19 (prioritate minima)."
    info "Implicit, procesele pornesc cu nice=0. Doar root poate seta valori negative."
    echo ""
    cmd "nice -n 10 comanda"      "porneste cu prioritate redusa (+10)"
    cmd "nice -n -5 comanda"      "prioritate ridicata (doar root)"
    cmd "renice 5 -p PID"         "modifica prioritatea unui proces activ"
    cmd "renice -5 -u user"       "modifica pt toate procesele unui user"
    cmd "ps -eo pid,ni,user,comm --sort=-ni | head -10" "procese sortate dupa nice"
    echo ""
    tip "Folositi nice pentru job-uri grele (compilare, backup) ca sa nu blocheze sistemul."
    echo ""
    examples_menu "Prioritati" \
        "ps -eo pid,ni,user,comm --sort=-ni | head -15"  "procese cu nice mai mare" \
        "ps -eo pid,ni,user,comm --sort=ni | head -15"   "procese cu nice mai mic (prioritare)" \
        "nice -n 15 bash -c 'echo Rulat cu nice=15; sleep 1; echo Done'"  \
                                                         "ruleaza o comanda cu prioritate mica"
}

cap5_5() {
    header; banner "Servicii si Systemd" "🔧"

    info "Ubuntu modern foloseste systemd pentru gestionarea serviciilor (daemon-urilor)."
    info "Serviciile pornesc automat la boot si pot fi controlate cu systemctl."
    echo ""
    cmd "systemctl status nginx"    "starea detaliata a serviciului"
    cmd "systemctl start nginx"     "porneste serviciul"
    cmd "systemctl stop nginx"      "opreste serviciul"
    cmd "systemctl restart nginx"   "opreste si reporneste"
    cmd "systemctl reload nginx"    "reincarca configuratia fara oprire"
    cmd "systemctl enable nginx"    "pornire automata la fiecare boot"
    cmd "systemctl disable nginx"   "dezactiveaza pornirea automata"
    cmd "systemctl is-active nginx" "verifica rapid daca ruleaza"
    cmd "journalctl -u nginx -f"    "loguri live ale serviciului"
    cmd "journalctl -u nginx -n 50" "ultimele 50 de linii de log"
    echo ""
    tip "journalctl --since '1 hour ago' afiseaza logurile din ultima ora."
    echo ""
    examples_menu "Servicii" \
        "systemctl list-units --type=service --state=running 2>/dev/null | head -20 || echo 'systemd indisponibil (WSL?)'" \
                                               "servicii active" \
        "systemctl list-unit-files --type=service 2>/dev/null | head -20" \
                                               "toate serviciile (enabled/disabled)" \
        "journalctl -n 20 2>/dev/null || echo 'journalctl indisponibil'" \
                                               "ultimele 20 intrari din jurnal" \
        "systemctl is-active ssh 2>/dev/null && echo SSH activ || echo SSH inactiv" \
                                               "verifica daca SSH ruleaza"
}

cap5_menu() {
    while true; do
        header; banner "Capitolul 5 — Procese si Semnale" "⚙️"
        echo -e "  ${C}1.${N} Monitorizare procese   ${DIM}(ps, top, pstree)${N}"
        echo -e "  ${C}2.${N} Background / Foreground ${DIM}(bg, fg, jobs, nohup)${N}"
        echo -e "  ${C}3.${N} Semnale               ${DIM}(kill, killall, pkill)${N}"
        echo -e "  ${C}4.${N} Prioritati             ${DIM}(nice, renice)${N}"
        echo -e "  ${C}5.${N} Servicii si Systemd    ${DIM}(systemctl, journalctl)${N}"
        echo -e "  ${M}s.${N} Sandbox Terminal        ${DIM}(tasteaza orice comanda)${N}"
        echo -e "  ${R}0.${N} Inapoi"
        echo ""
        echo -e "  ${BC}${S}${N}"
        echo -ne "  Alegeti (0-5/s): "; read -r o
        case $o in
            1)cap5_1;; 2)cap5_2;; 3)cap5_3;; 4)cap5_4;; 5)cap5_5;;
            s|S)sandbox;; 0)return;; *)invalid;;
        esac
    done
}

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  CAP 6 — SHELL SCRIPTING
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

cap6_1() {
    header; banner "Variabile" "💾"

    info "Variabilele stocheaza date temporar in sesiunea curenta de shell."
    info "Atribuire fara spatii: VAR=valoare  |  Acces cu: \$VAR sau \${VAR}"
    echo ""
    cmd "NUME='Costel'"          "atribuire simpla (fara spatii langa =!)"
    cmd 'echo $NUME'             "afiseaza valoarea variabilei"
    cmd '"Salut $NUME"'          "expansiune in ghilimele DUBLE"
    cmd "'Salut \$NUME'"         "fara expansiune in ghilimele SIMPLE"
    cmd 'SUMA=$((3 + 4 * 2))'   "calcul aritmetic"
    cmd 'DATA=$(date +%Y-%m-%d)' "captureaza output-ul unei comenzi"
    cmd "export VAR='val'"       "marcheaza variabila ca accesibila in subprocese"
    cmd "unset VAR"              "sterge variabila"
    echo ""
    info "Variabile speciale de mediu:"
    cmd "\$HOME"    "directorul home al utilizatorului curent"
    cmd "\$PATH"    "lista de directoare unde se cauta executabilele"
    cmd "\$USER"    "numele utilizatorului curent"
    cmd "\$SHELL"   "shell-ul implicit al utilizatorului"
    cmd "\$PWD"     "directorul de lucru curent"
    cmd "\$RANDOM"  "numar aleator intre 0 si 32767"
    echo ""
    examples_menu "Variabile" \
        'echo "HOME=$HOME | USER=$USER | SHELL=$SHELL"'            "variabile de mediu" \
        'echo $PATH | tr ":" "\n"'                                 "PATH afisat pe linii separate" \
        'echo "Calcul: 15 * 7 + 3 = $((15 * 7 + 3))"'            "calcul aritmetic" \
        'ORAS="Chisinau"; echo "Buna ziua din $ORAS! $(date +%d/%m/%Y)"' \
                                                                    "variabila locala + data" \
        'RAND=$RANDOM; echo "Numar aleator: $RAND (impar? $((RAND % 2)))"' \
                                                                    "numar aleator"
}

cap6_2() {
    header; banner "Citirea Datelor: read si Argumente" "⌨️"

    info "'read' citeste o linie de la utilizator si o stocheaza intr-o variabila."
    echo ""
    cmd "read VAR"              "citeste o linie"
    cmd "read -p 'Mesaj: ' VAR" "cu prompt personalizat"
    cmd "read -s VAR"           "silent — nu afiseaza caracterele (parole)"
    cmd "read -t 5 VAR"         "timeout: abandoneaza daca nu raspunde in 5s"
    cmd "read -a ARRAY"         "citeste mai multe cuvinte intr-un array"
    echo ""
    info "Variabile speciale in scripturi:"
    cmd "\$0"     "numele scriptului"
    cmd "\$1 \$2"  "argumentele pozitionale (de la linia de comanda)"
    cmd "\$#"     "numarul de argumente primite"
    cmd "\$@"     "toate argumentele ca lista separata"
    cmd "\$?"     "exit code al ultimei comenzi (0=succes, alt=eroare)"
    cmd "\$\$"    "PID-ul scriptului curent"
    cmd "\$!"     "PID-ul ultimului proces lansat in background"
    echo ""
    examples_menu "Read si Argumente" \
        'echo "Script: $0  |  PID: $$  |  User: $USER"'           "variabile speciale" \
        'read -p "Scrie un cuvant: " W; echo "Ai scris: $W (${#W} caractere)"' \
                                                                    "citire cu prompt" \
        'read -t 3 -p "Raspunde rapid (3s): " R && echo "Ai scris: $R" || echo "Timeout!"' \
                                                                    "read cu timeout" \
        'echo "zero one two" | (read a b c; echo "a=$a b=$b c=$c")'  \
                                                                    "read mai multe variabile"
}

cap6_3() {
    header; banner "Structuri Conditionale: if / case" "🔀"

    info "Structurile conditionale controleaza fluxul executiei scriptului."
    echo ""
    echo -e "  ${BG_CMD}${Y}"
    echo -e "    if [ conditie ]; then"
    echo -e "        comenzi"
    echo -e "    elif [ alta_conditie ]; then"
    echo -e "        comenzi"
    echo -e "    else"
    echo -e "        comenzi_default"
    echo -e "    fi${N}"
    echo ""
    info "Operatori numerici:  -eq  -ne  -lt  -le  -gt  -ge"
    info "Operatori siruri:    =  !=  -z (gol)  -n (nevid)  <  >"
    info "Operatori fisiere:   -f (fisier)  -d (director)  -e (exista)  -r  -w  -x"
    tip  "Preferati [[ ]] in loc de [ ] — suporta regex, && ||, si nu are probleme cu spatii."
    echo ""
    examples_menu "Conditionale" \
        'VARSTA=20; if [ $VARSTA -ge 18 ]; then echo "Major ($VARSTA ani)"; else echo "Minor"; fi' \
                                             "if numeric" \
        'if [[ -f /etc/hosts && -r /etc/hosts ]]; then echo "exista si e citibil: $(wc -l < /etc/hosts) linii"; fi' \
                                             "if cu fisier + logic AND" \
        '[[ $(uname -s) == "Linux" ]] && echo "Linux: $(uname -r)" || echo "Alt SO"' \
                                             "operator ternar cu &&/||" \
        'SHELL_NAME=$(basename $SHELL)
case $SHELL_NAME in
  bash) echo "Folosesti Bash — clasic si stabil";;
  zsh)  echo "Folosesti Zsh — cu plugin-uri!";;
  fish) echo "Folosesti Fish — prietenos!";;
  *)    echo "Shell: $SHELL_NAME";;
esac'                                        "case pe shell-ul curent"
}

cap6_4() {
    header; banner "Bucle: for / while / until" "🔁"

    info "Buclele repeta executia unor comenzi pentru fiecare element sau cat timp o conditie e adevarata."
    echo ""
    echo -e "  ${BG_CMD}${Y}"
    echo -e "    for var in lista; do comenzi; done"
    echo -e "    for ((i=0; i<10; i++)); do comenzi; done"
    echo -e "    while [ conditie ]; do comenzi; done"
    echo -e "    until [ conditie ]; do comenzi; done${N}"
    echo ""
    cmd "break"     "iese imediat din bucla"
    cmd "continue"  "sare la urmatoarea iteratie"
    tip "Bucla 'until' este opusul lui 'while': ruleaza pana cand conditia devine ADEVARATA."
    echo ""
    examples_menu "Bucle" \
        'for i in {1..5}; do echo "  Iteratia $i"; done'                   "for cu range" \
        'for user in $(cut -d: -f1 /etc/passwd | head -6); do echo "  User: $user"; done' \
                                                                             "for pe useri" \
        'COUNT=1; while [ $COUNT -le 5 ]; do echo "  While #$COUNT"; COUNT=$((COUNT+1)); done' \
                                                                             "while cu contor" \
        'for f in /etc/*.conf; do [ -f "$f" ] && echo "  $(basename "$f") — $(wc -l < "$f") linii"; done 2>/dev/null | head -10' \
                                                                             "for pe fisiere .conf"
}

cap6_5() {
    header; banner "Functii" "🧩"

    info "Functiile grupeaza comenzi care pot fi reutilizate si parametrizate."
    echo ""
    echo -e "  ${BG_CMD}${Y}"
    echo -e "    nume_functie() {"
    echo -e "        comenzi"
    echo -e "        return 0    # 0=succes, 1=eroare"
    echo -e "    }"
    echo -e "    # apel: nume_functie arg1 arg2${N}"
    echo ""
    info "Argumente: \$1, \$2 ...  |  \$# = nr argumente  |  return seteaza \$?"
    tip  "Variabilele din functii sunt globale by default. Folositi 'local var' pentru variabile locale."
    echo ""
    examples_menu "Functii" \
        'salut() { echo "Buna, $1! Ai $2 ani."; }; salut "Costel" "20"' \
                                          "functie simpla" \
        'patrat() { echo $(($1 * $1)); }; echo "7 la patrat = $(patrat 7)"' \
                                          "functie care returneaza valoare" \
        'info_fisier() {
    local f="$1"
    if [[ -f "$f" ]]; then
        printf "  %-30s  %5s linii  %s\n" "$f" "$(wc -l < "$f")" "$(stat -c %A "$f" 2>/dev/null)"
    else
        echo "  $f nu exista!"
    fi
}
info_fisier /etc/hosts
info_fisier /etc/hostname
info_fisier /etc/fisier_inexistent' \
                                          "functie cu variabila locala"
}

cap6_6() {
    header; banner "Filtre si Pipe: grep, sed, awk, sort, cut" "🔗"

    info "Pipe-ul (|) conecteaza comenzi: output-ul uneia devine input-ul urmatoarei."
    info "Aceasta filozofie UNIX (programe mici, specializate) este extrem de puternica."
    echo ""
    cmd "grep 'text' fisier"        "cauta un pattern (regex suportat)"
    cmd "sed 's/vechi/nou/g' f"     "substitutie globala de text"
    cmd "sed -n '5,10p' fisier"     "afiseaza liniile 5-10"
    cmd "awk -F: '{print \$1}'"     "extrage prima coloana (separator :)"
    cmd "awk '\$3 > 1000'"          "filtreaza randuri dupa valoare"
    cmd "sort"                      "sorteaza linii alfabetic"
    cmd "sort -rn"                  "sorteaza numeric invers (descrescator)"
    cmd "uniq"                      "elimina linii duplicate adiacente"
    cmd "cut -d: -f1,3"            "extrage campurile 1 si 3 (separator :)"
    cmd "wc -l / wc -w / wc -c"    "numara linii / cuvinte / caractere"
    cmd "tr 'a-z' 'A-Z'"           "transforma caractere (lowercase->uppercase)"
    cmd "tee fisier"               "scrie si pe ecran si in fisier simultan"
    echo ""
    tip "Combinati: cat f | sort | uniq -c | sort -rn | head -10 (top cuvinte frecvente)"
    echo ""
    examples_menu "Filtre si Pipe" \
        "cut -d: -f1,7 /etc/passwd | sort | column -t -s:"      "useri si shell-urile lor" \
        "ps aux --sort=-%mem | awk 'NR<=8 {printf \"%-12s %5s%% mem\\n\", \$1, \$4}'" \
                                                                  "top procese dupa memorie" \
        "echo 'hello linux world' | tr 'a-z' 'A-Z'"              "uppercase" \
        "df -h | grep -v tmpfs | awk 'NR>1 {printf \"%-20s %s folosit\\n\", \$1, \$5}'" \
                                                                  "disk usage curat" \
        "cat /etc/passwd | cut -d: -f7 | sort | uniq -c | sort -rn" \
                                                                  "shell-uri folosite si frecventa"
}

cap6_menu() {
    while true; do
        header; banner "Capitolul 6 — Shell Scripting" "💻"
        echo -e "  ${C}1.${N} Variabile              ${DIM}(declarare, export, speciale)${N}"
        echo -e "  ${C}2.${N} Citire date            ${DIM}(read, argumente \$1 \$# \$@)${N}"
        echo -e "  ${C}3.${N} Conditii               ${DIM}(if, elif, case, operatori)${N}"
        echo -e "  ${C}4.${N} Bucle                  ${DIM}(for, while, until)${N}"
        echo -e "  ${C}5.${N} Functii                ${DIM}(declarare, local, return)${N}"
        echo -e "  ${C}6.${N} Filtre si Pipe         ${DIM}(grep, sed, awk, sort, cut)${N}"
        echo -e "  ${M}s.${N} Sandbox Terminal        ${DIM}(tasteaza orice comanda)${N}"
        echo -e "  ${R}0.${N} Inapoi"
        echo ""
        echo -e "  ${BC}${S}${N}"
        echo -ne "  Alegeti (0-6/s): "; read -r o
        case $o in
            1)cap6_1;; 2)cap6_2;; 3)cap6_3;; 4)cap6_4;; 5)cap6_5;; 6)cap6_6;;
            s|S)sandbox;; 0)return;; *)invalid;;
        esac
    done
}

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  CAP 7 — ADMINISTRAREA SOFTWARE-ULUI
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

cap7_1() {
    header; banner "Gestiunea Pachetelor cu APT" "📦"

    info "APT (Advanced Package Tool) este managerul de pachete pentru Debian/Ubuntu."
    info "Pachetele (.deb) sunt stocate in repository-uri (depozite online)."
    info "Fisierul /etc/apt/sources.list defineste repository-urile active."
    echo ""
    cmd "apt update"              "descarca lista actualizata a pachetelor (nu instaleaza)"
    cmd "apt upgrade"             "actualizeaza toate pachetele instalate"
    cmd "apt full-upgrade"        "actualizeaza + rezolva dependente (poate sterge pachete)"
    cmd "apt install pachet"      "instaleaza un pachet"
    cmd "apt install -y pachet"   "instaleaza fara confirmare interactiva"
    cmd "apt remove pachet"       "dezinstaleaza (pastreaza fisierele de configurare)"
    cmd "apt purge pachet"        "dezinstaleaza + sterge configuratia"
    cmd "apt autoremove"          "sterge dependentele neutilizate"
    cmd "apt search cuvant"       "cauta un pachet in repository"
    cmd "apt show pachet"         "afiseaza detalii (versiune, marime, dependente)"
    cmd "apt list --installed"    "toate pachetele instalate"
    cmd "dpkg -l"                 "lista pachete la nivel jos (dpkg)"
    cmd "dpkg -L pachet"          "fisierele instalate de un pachet"
    echo ""
    tip "Rulati intotdeauna 'apt update' inainte de 'apt install' pentru a fi up-to-date."
    echo ""
    examples_menu "APT" \
        "apt list --installed 2>/dev/null | wc -l | xargs -I{} echo '{} pachete instalate'" \
                                                              "numarul de pachete" \
        "dpkg -l | tail -15"                                  "ultimele pachete instalate" \
        "apt-cache show curl 2>/dev/null | grep -E '(Package|Version|Installed-Size|Description)' | head -6" \
                                                              "detalii despre pachetul curl" \
        "apt-cache depends bash 2>/dev/null | head -15"       "dependentele pachetului bash" \
        "dpkg -L bash | head -15"                             "fisierele instalate de bash"
}

cap7_2() {
    header; banner "Instalare si Dezinstalare" "🔨"

    info "Fluxul tipic de lucru cu APT:"
    echo ""
    echo -e "  ${BG_CMD}${Y}"
    echo -e "    sudo apt update              # 1. Actualizeaza lista"
    echo -e "    sudo apt install htop -y     # 2. Instaleaza pachetul"
    echo -e "    which htop && htop --version # 3. Verifica instalarea${N}"
    echo ""
    info "Dezinstalare:"
    cmd "sudo apt remove htop"      "sterge pachetul, pastreaza config"
    cmd "sudo apt purge htop"       "sterge totul inclusiv config"
    cmd "sudo apt autoremove"       "curata dependentele orfane"
    echo ""
    info "Alte surse de pachete:"
    cmd "snap install pachet"       "Snap (pachete universale, sandboxate)"
    cmd "flatpak install pachet"    "Flatpak (alternative universale)"
    cmd "pip install pachet"        "Python packages"
    cmd "dpkg -i pachet.deb"        "instalare manuala dintr-un .deb local"
    echo ""
    tip "snap si flatpak au propriile sandbox-uri si nu depind de APT."
    echo ""
    examples_menu "Instalare Pachete" \
        "which curl wget git python3 2>/dev/null"   "utilitare comune instalate" \
        "snap list 2>/dev/null | head -10 || echo 'snap indisponibil'"  \
                                                    "pachete snap instalate" \
        "pip3 list 2>/dev/null | head -10 || echo 'pip3 indisponibil'"  \
                                                    "pachete Python instalate" \
        "dpkg -l | grep -E '^ii' | awk '{print \$2, \$3}' | tail -10"  \
                                                    "pachete recent instalate"
}

cap7_3() {
    header; banner "Informatii Hardware si Analiza Sistem" "🖥️"

    info "Linux expune informatii hardware prin fisiere in /proc si /sys."
    echo ""
    cmd "lscpu"          "procesor: arhitectura, core-uri, frecventa, cache"
    cmd "free -h"        "memorie RAM si swap (human-readable)"
    cmd "lsblk"          "dispozitive de stocare si partitii"
    cmd "df -h"          "spatiu liber pe disk (per partitie)"
    cmd "du -sh dir/"    "spatiul ocupat de un director"
    cmd "lspci"          "dispozitive PCI (placa video, retea)"
    cmd "lsusb"          "dispozitive USB conectate"
    cmd "uname -a"       "versiunea kernel-ului si arhitectura"
    cmd "uname -r"       "doar versiunea kernel-ului"
    cmd "uptime"         "timp de functionare + load average (1/5/15 min)"
    cmd "hostname"       "numele calculatorului in retea"
    cmd "cat /proc/cpuinfo | head -20" "informatii brute despre CPU"
    cmd "cat /proc/meminfo | head -10" "informatii brute despre memorie"
    echo ""
    tip "Load average > numarul de core-uri = sistemul este supraincarctat."
    echo ""
    examples_menu "Hardware" \
        "uname -a"                     "kernel si arhitectura" \
        "lscpu | grep -E '(Architecture|Model name|CPU|Thread|Core|Socket|MHz)'" \
                                       "informatii CPU" \
        "free -h"                      "RAM si swap" \
        "df -h | grep -v tmpfs | grep -v loop" \
                                       "disk usage" \
        "uptime && echo '' && cat /proc/loadavg" \
                                       "uptime si load average"
}

cap7_menu() {
    while true; do
        header; banner "Capitolul 7 — Administrarea Software-ului" "📦"
        echo -e "  ${C}1.${N} Gestiunea pachetelor APT  ${DIM}(update, install, remove)${N}"
        echo -e "  ${C}2.${N} Instalare si dezinstalare  ${DIM}(snap, pip, dpkg)${N}"
        echo -e "  ${C}3.${N} Informatii hardware         ${DIM}(lscpu, free, df, lsblk)${N}"
        echo -e "  ${M}s.${N} Sandbox Terminal             ${DIM}(tasteaza orice comanda)${N}"
        echo -e "  ${R}0.${N} Inapoi"
        echo ""
        echo -e "  ${BC}${S}${N}"
        echo -ne "  Alegeti (0-3/s): "; read -r o
        case $o in
            1)cap7_1;; 2)cap7_2;; 3)cap7_3;;
            s|S)sandbox;; 0)return;; *)invalid;;
        esac
    done
}

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  CAP 8 — CONFIGURAREA RETELEI
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

cap8_1() {
    header; banner "Interfete de Retea (ip addr, ifconfig)" "🌐"

    info "Interfetele de retea sunt canalele prin care calculatorul comunica in retea."
    echo ""
    cmd "ip addr"               "afiseaza toate interfetele si adresele IP"
    cmd "ip addr show eth0"     "afiseaza o interfata specifica"
    cmd "ip -br addr"           "format scurt, usor de citit"
    cmd "ip link"               "starea interfetelor (up/down)"
    cmd "ip link set eth0 up"   "activeaza o interfata"
    cmd "ifconfig"              "comanda clasica (net-tools, deprecated)"
    echo ""
    info "Tipuri comune de interfete:"
    cmd "eth0 / enp3s0"    "Ethernet cablata"
    cmd "wlan0 / wlp2s0"   "WiFi (wireless)"
    cmd "lo"               "loopback (127.0.0.1 — comunicare locala)"
    cmd "docker0 / virbr0" "interfete virtuale (containere, VM)"
    echo ""
    info "Notatia CIDR: 192.168.1.100/24"
    info "  /24 = masca 255.255.255.0 — 254 host-uri in retea"
    tip  "Prefixul /prefix indica cati biti sunt pentru retea. /24 = 256 adrese."
    echo ""
    examples_menu "Interfete" \
        "ip -br addr"                             "interfete scurt" \
        "ip addr"                                 "interfete detaliat" \
        "ip link show"                            "starea interfetelor" \
        "cat /proc/net/if_inet6 2>/dev/null | awk '{print \$1, \$6}' | head -10 || echo 'fara IPv6'" \
                                                  "adrese IPv6"
}

cap8_2() {
    header; banner "Testare Conectivitate: ping, traceroute" "📶"

    info "ping trimite pachete ICMP Echo Request si masoara latenta."
    echo ""
    cmd "ping -c 4 8.8.8.8"       "4 pachete catre Google DNS"
    cmd "ping -c 4 -i 0.2 host"   "interval 0.2s intre pachete"
    cmd "ping -s 1400 host"        "pachete de 1400 bytes (test MTU)"
    cmd "traceroute host"          "urmareste ruta pachetelor (necesita root/UDP)"
    cmd "tracepath host"           "similar, fara privilegii root"
    cmd "mtr host"                 "ping + traceroute interactiv (apt install mtr)"
    echo ""
    tip "ping -f host (flood) — doar root, util pentru testare retea locala."
    warn "Unele firewall-uri blocheaza ICMP, deci ping poate esua chiar daca hostul e activ."
    echo ""
    examples_menu "Conectivitate" \
        "ping -c 3 8.8.8.8"                      "ping catre Google DNS" \
        "ping -c 3 google.com 2>/dev/null || echo 'DNS sau retea indisponibila'" \
                                                  "ping cu hostname" \
        "tracepath -m 10 8.8.8.8 2>/dev/null || traceroute -m 10 8.8.8.8 2>/dev/null || echo 'tracepath/traceroute indisponibil'" \
                                                  "traseul pachetelor"
}

cap8_3() {
    header; banner "Rutare si Gateway (ip route)" "🗺️"

    info "Tabela de rutare decide pe ce interfata ies pachetele catre diverse destinatii."
    echo ""
    cmd "ip route"                      "afiseaza tabela de rutare"
    cmd "ip route show default"         "ruta implicita (gateway)"
    cmd "ip route get 8.8.8.8"          "pe ce interfata iese catre 8.8.8.8"
    cmd "ip route add 10.0.0.0/8 via GW" "adauga o ruta statica"
    cmd "ip route del 10.0.0.0/8"       "sterge o ruta"
    cmd "ip route flush cache"          "goleste cache-ul de rutare"
    echo ""
    info "Default gateway = routerul prin care iese tot traficul fara ruta specifica."
    tip  "ip route get <IP> este util pentru debug — arata exact pe unde iese un pachet."
    echo ""
    examples_menu "Rutare" \
        "ip route show"                   "tabela de rutare completa" \
        "ip route show default"           "ruta implicita (gateway)" \
        "ip route get 8.8.8.8 2>/dev/null || echo 'indisponibil'" \
                                          "pe ce interfata iese catre 8.8.8.8" \
        "ip route get 192.168.1.1 2>/dev/null || echo 'indisponibil'" \
                                          "pe ce interfata iese catre gateway local"
}

cap8_4() {
    header; banner "Porturi si Servicii (ss, netstat)" "🔌"

    info "Porturile identifica serviciile de retea pe un host (0-65535)."
    echo ""
    info "Porturi standard comune:"
    cmd "22   SSH"       "acces shell securizat"
    cmd "25   SMTP"      "trimitere email"
    cmd "53   DNS"       "rezolutie nume de domeniu"
    cmd "80   HTTP"      "web nesecurizat"
    cmd "443  HTTPS"     "web securizat (TLS)"
    cmd "3306 MySQL"     "baza de date MySQL/MariaDB"
    cmd "5432 PostgreSQL" "baza de date PostgreSQL"
    echo ""
    cmd "ss -tuln"           "porturi TCP/UDP in ascultare (fara DNS)"
    cmd "ss -tulnp"          "cu procesul asociat (necesita root)"
    cmd "ss -s"              "statistici sumare retea"
    cmd "ss -ant | grep ESTABLISHED" "conexiuni active"
    cmd "netstat -tuln"      "alternativa clasica (pachetul net-tools)"
    echo ""
    tip "ss este inlocuitorul modern al netstat. Mai rapid si mai detaliat."
    echo ""
    examples_menu "Porturi" \
        "ss -tuln"                               "toate porturile deschise" \
        "ss -ant | grep ESTABLISHED | head -10"  "conexiuni active" \
        "ss -s"                                  "statistici retea" \
        "cat /etc/services | grep -E '^\s*(ssh|http|https|ftp|smtp)\s'" \
                                                 "servicii cunoscute din /etc/services"
}

cap8_5() {
    header; banner "DNS: nslookup, dig, /etc/hosts" "🔤"

    info "DNS (Domain Name System) traduce hostname-uri in adrese IP."
    info "Rezolutia: aplicatie → /etc/hosts → /etc/resolv.conf → server DNS."
    echo ""
    cmd "nslookup google.com"             "interogare DNS simpla"
    cmd "dig google.com"                  "interogare DNS detaliata"
    cmd "dig +short google.com"           "doar adresa IP"
    cmd "dig @8.8.8.8 google.com"         "interogheaza un server DNS specific"
    cmd "dig -x 8.8.8.8"                  "reverse lookup (IP → hostname)"
    cmd "host google.com"                 "interogare rapida"
    cmd "cat /etc/resolv.conf"            "serverele DNS configurate"
    cmd "cat /etc/hosts"                  "rezolutie locala manuala"
    cmd "getent hosts google.com"         "rezolutie prin NSS (ca aplicatiile)"
    echo ""
    tip "/etc/hosts are prioritate fata de DNS — util pentru blocare sau redirectionare locala."
    echo ""
    examples_menu "DNS" \
        "cat /etc/resolv.conf"            "serverele DNS configurate" \
        "cat /etc/hosts"                  "fisierul hosts local" \
        "nslookup google.com 2>/dev/null || host google.com 2>/dev/null || echo 'nslookup indisponibil'" \
                                          "rezolvare DNS google.com" \
        "dig +short google.com 2>/dev/null || echo 'dig indisponibil (apt install dnsutils)'" \
                                          "IP-ul google.com (dig)" \
        "getent hosts localhost"          "rezolutie locala localhost"
}

cap8_menu() {
    while true; do
        header; banner "Capitolul 8 — Configurarea Retelei" "🌐"
        echo -e "  ${C}1.${N} Interfete de retea      ${DIM}(ip addr, ip link, ifconfig)${N}"
        echo -e "  ${C}2.${N} Testare conectivitate   ${DIM}(ping, tracepath, traceroute)${N}"
        echo -e "  ${C}3.${N} Rutare si gateway       ${DIM}(ip route)${N}"
        echo -e "  ${C}4.${N} Porturi si servicii     ${DIM}(ss, netstat)${N}"
        echo -e "  ${C}5.${N} DNS                     ${DIM}(nslookup, dig, /etc/hosts)${N}"
        echo -e "  ${M}s.${N} Sandbox Terminal         ${DIM}(tasteaza orice comanda)${N}"
        echo -e "  ${R}0.${N} Inapoi"
        echo ""
        echo -e "  ${BC}${S}${N}"
        echo -ne "  Alegeti (0-5/s): "; read -r o
        case $o in
            1)cap8_1;; 2)cap8_2;; 3)cap8_3;; 4)cap8_4;; 5)cap8_5;;
            s|S)sandbox;; 0)return;; *)invalid;;
        esac
    done
}

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  CAP 12 — SERVERUL E-MAIL
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

cap12_1() {
    header; banner "Protocoale E-mail" "✉️"

    info "Fluxul unui email de la expeditor la destinatar:"
    echo ""
    echo -e "  ${Y}[Client MUA]${N} ──SMTP──▶ ${G}[MTA Expeditor]${N} ──SMTP──▶ ${G}[MTA Destinatar]${N} ──IMAP/POP3──▶ ${Y}[Client MUA]${N}"
    echo ""
    cmd "SMTP (25, 587, 465)"  "Simple Mail Transfer Protocol — trimitere email"
    cmd "IMAP (143, 993)"      "Internet Message Access — citire, mesajele raman pe server"
    cmd "POP3 (110, 995)"      "Post Office Protocol — descarca si sterge de pe server"
    echo ""
    info "Componente:"
    cmd "MTA"    "Mail Transfer Agent: transfer intre servere (Postfix, Sendmail, Exim)"
    cmd "MDA"    "Mail Delivery Agent: livrare in cutia postala (Dovecot, Procmail)"
    cmd "MUA"    "Mail User Agent: clientul utilizatorului (Thunderbird, mutt, Evolution)"
    echo ""
    info "Porturi securizate (SSL/TLS):"
    cmd "465"    "SMTPS — SMTP cu SSL implicit"
    cmd "587"    "SMTP Submission — recomandat pentru clienti (STARTTLS)"
    cmd "993"    "IMAPS — IMAP cu SSL"
    cmd "995"    "POP3S — POP3 cu SSL"
    tip  "Port 25 este pentru comunicare intre servere (MTA-to-MTA), nu pentru clienti."
    echo ""
    examples_menu "Protocoale Email" \
        "ss -tln | grep -E ':25|:587|:993|:143|:110' || echo 'Niciun serviciu email activ'" \
                                        "porturi email deschise" \
        "which postfix sendmail exim4 2>/dev/null || echo 'Niciun MTA instalat'" \
                                        "MTA-uri instalate"
}

cap12_2() {
    header; banner "Postfix: Instalare si Configurare" "📮"

    info "Postfix este cel mai popular MTA Linux — securizat, performant, bine documentat."
    echo ""
    cmd "sudo apt install postfix"      "instaleaza Postfix"
    cmd "systemctl status postfix"      "verifica starea serviciului"
    cmd "postfix check"                 "verifica configuratia pentru erori"
    cmd "postfix reload"                "reincarca configuratia fara restart"
    echo ""
    info "Fisierul principal: /etc/postfix/main.cf"
    cmd "myhostname = mail.exemplu.com"   "FQDN al serverului de email"
    cmd "mydomain = exemplu.com"          "domeniul principal"
    cmd "inet_interfaces = all"           "asculta pe toate interfetele"
    cmd "mydestination = \$myhostname, ..." "domenii pentru care accepta email"
    cmd "mynetworks = 127.0.0.0/8"        "retele de incredere (pot trimite)"
    cmd "relay_host = [smtp.isp.ro]"      "relay prin furnizor ISP"
    echo ""
    info "Administrare coada de email:"
    cmd "mailq"          "afiseaza coada de email in asteptare"
    cmd "postqueue -f"   "retrimitere fortata a cozii"
    cmd "postsuper -d ALL" "sterge toate email-urile din coada"
    echo ""
    examples_menu "Postfix" \
        "which postfix 2>/dev/null && postfix status 2>/dev/null || echo 'Postfix nu este instalat'" \
                                        "starea Postfix" \
        "[ -f /etc/postfix/main.cf ] && grep -v '^#' /etc/postfix/main.cf | grep -v '^$' | head -15 || echo 'main.cf absent'" \
                                        "configuratia activa Postfix" \
        "mailq 2>/dev/null || echo 'mailq indisponibil'"  \
                                        "coada de email"
}

cap12_3() {
    header; banner "Testare si Monitorizare Email" "🔎"

    info "Trimitere email de test din linie de comanda:"
    echo ""
    cmd "echo 'Test' | mail -s 'Subiect' user@exemplu.com" "trimite email simplu"
    cmd "echo 'Test' | sendmail user@exemplu.com"           "via sendmail"
    cmd "swaks --to user@exemplu.com --server localhost"    "test SMTP complet"
    echo ""
    info "Monitorizare:"
    cmd "tail -f /var/log/mail.log"      "loguri Postfix in timp real"
    cmd "journalctl -u postfix -f"       "loguri via systemd"
    cmd "mailq"                          "coada de email"
    echo ""
    info "Inregistrari DNS necesare pentru un server email profesional:"
    cmd "MX record"   "specifica serverul de email al domeniului"
    cmd "A record"    "adresa IP a serverului (PTR reverse trebuie sa corespunda)"
    cmd "SPF record"  "lista serverelor autorizate sa trimita pentru domeniu"
    cmd "DKIM"        "semnatura digitala criptografica a email-urilor"
    cmd "DMARC"       "politici de aplicat la esecul SPF sau DKIM"
    tip  "Fara SPF, DKIM si DMARC, email-urile ajung in Spam la destinatar."
    echo ""
    examples_menu "Monitorizare Email" \
        "[ -f /var/log/mail.log ] && tail -10 /var/log/mail.log 2>/dev/null || echo 'Log mail absent'" \
                                        "ultimele loguri email" \
        "ss -tln | grep ':25 ' && echo 'SMTP activ' || echo 'SMTP inactiv'"  \
                                        "portul SMTP 25"
}

cap12_menu() {
    while true; do
        header; banner "Capitolul 12 — Serverul E-mail" "✉️"
        echo -e "  ${C}1.${N} Protocoale              ${DIM}(SMTP, IMAP, POP3)${N}"
        echo -e "  ${C}2.${N} Postfix                  ${DIM}(instalare, configurare)${N}"
        echo -e "  ${C}3.${N} Testare si monitorizare  ${DIM}(mail, loguri, DNS records)${N}"
        echo -e "  ${M}s.${N} Sandbox Terminal          ${DIM}(tasteaza orice comanda)${N}"
        echo -e "  ${R}0.${N} Inapoi"
        echo ""
        echo -e "  ${BC}${S}${N}"
        echo -ne "  Alegeti (0-3/s): "; read -r o
        case $o in
            1)cap12_1;; 2)cap12_2;; 3)cap12_3;;
            s|S)sandbox;; 0)return;; *)invalid;;
        esac
    done
}

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  CAP 13 — SERVERUL NTP
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

cap13_1() {
    header; banner "NTP — Network Time Protocol" "⏰"

    info "NTP sincronizeaza ceasurile computerelor din retea cu o sursa de timp precisă."
    info "Ceasuri nesincronizate cauzeaza: certificate SSL invalide, erori loguri, esuari autentificare Kerberos."
    echo ""
    info "Ierarhia Stratum (precizie):"
    cmd "Stratum 0"    "surse de referinta: ceasuri atomice, GPS, CDMA"
    cmd "Stratum 1"    "conectat direct la Stratum 0 (servere primare NTP)"
    cmd "Stratum 2"    "sincronizat de la Stratum 1 (pool.ntp.org)"
    cmd "Stratum 3-15" "cascada de sincronizare (precizie scade cu fiecare nivel)"
    echo ""
    info "Servere NTP publice:"
    cmd "pool.ntp.org"           "pool global rotativ (recomandat)"
    cmd "0-3.ro.pool.ntp.org"   "pool Romania (4 servere regionale)"
    cmd "time.google.com"        "Google public NTP"
    cmd "time.cloudflare.com"    "Cloudflare public NTP"
    cmd "time.windows.com"       "Microsoft (NTP compatibil)"
    echo ""
    info "Implementari pe Ubuntu:"
    cmd "systemd-timesyncd"   "client simplu NTP (implicit Ubuntu)"
    cmd "chrony"              "client + server NTP (mai performant)"
    cmd "ntpd"                "implementarea clasica (mai rar folosit)"
    tip "chrony este recomandat pentru servere si medii cu conectivitate intermitenta."
    echo ""
    examples_menu "NTP" \
        "timedatectl status"                               "starea sincronizarii timpului" \
        "date '+  Data: %d/%m/%Y  Ora: %H:%M:%S  TZ: %Z'" "data si ora curenta" \
        "cat /etc/timezone 2>/dev/null || timedatectl | grep 'Time zone'" \
                                                           "fusul orar configurat"
}

cap13_2() {
    header; banner "Configurare NTP / Chrony" "⚙️"

    info "systemd-timesyncd (implicit pe Ubuntu Desktop/Server):"
    echo ""
    cmd "/etc/systemd/timesyncd.conf"       "fisierul de configurare"
    cmd "timedatectl show-timesync --all"   "detalii despre sincronizare"
    cmd "systemctl restart systemd-timesyncd" "restart dupa modificari config"
    echo ""
    info "Chrony (mai puternic, poate fi si server NTP pentru retea locala):"
    cmd "sudo apt install chrony"         "instaleaza chrony"
    cmd "/etc/chrony/chrony.conf"         "fisierul de configurare"
    cmd "chronyc sources -v"              "sursele NTP active cu latenta"
    cmd "chronyc tracking"                "starea precisa a sincronizarii"
    cmd "chronyc makestep"                "sare la ora corecta imediat (fara graduala)"
    echo ""
    info "Configurare server chrony (distribuie timp in LAN):"
    cmd "server pool.ntp.org iburst"   "sursa NTP cu sincronizare initiala rapida"
    cmd "allow 192.168.1.0/24"         "permite clienti din reteaua locala"
    cmd "local stratum 10"             "fallback fara internet (stratum ridicat)"
    echo ""
    examples_menu "Configurare NTP" \
        "systemctl is-active systemd-timesyncd 2>/dev/null && echo 'timesyncd: ACTIV' || echo 'timesyncd: inactiv'" \
                                        "starea timesyncd" \
        "timedatectl show-timesync --all 2>/dev/null || echo 'Detalii sincronizare indisponibile'" \
                                        "informatii sincronizare" \
        "which chronyd 2>/dev/null && chronyc sources 2>/dev/null || echo 'chrony nu este instalat'"  \
                                        "sursele chrony" \
        "cat /etc/systemd/timesyncd.conf 2>/dev/null | grep -v '^#' | grep -v '^$'" \
                                        "configuratia timesyncd"
}

cap13_3() {
    header; banner "Gestionarea Orei (date, timedatectl, hwclock)" "🕐"

    info "Sistemul are doua ceasuri: software (kernel) si hardware RTC (bios)."
    echo ""
    cmd "date"                                  "ora curenta in format implicit"
    cmd "date +'%Y-%m-%d %H:%M:%S'"            "format personalizat ISO 8601"
    cmd "date -d 'yesterday' +'%Y-%m-%d'"      "data de ieri"
    cmd "date -d '+7 days' +'%Y-%m-%d'"        "data peste 7 zile"
    cmd "timedatectl status"                    "stare completa: ora, TZ, NTP"
    cmd "timedatectl list-timezones"            "lista tuturor fusurilor orare"
    cmd "timedatectl set-timezone Europe/Chisinau" "seteaza fusul orar Moldova"
    cmd "timedatectl set-timezone Europe/Bucharest" "seteaza fusul orar Romania"
    cmd "timedatectl set-ntp true"              "activeaza sincronizarea NTP"
    cmd "hwclock --show"                        "ceasul hardware RTC"
    cmd "hwclock --hctosys"                     "sincronizeaza ceasul software din RTC"
    echo ""
    tip "Fusul orar al sistemului afecteaza toate logurile si aplicatiile!"
    echo ""
    examples_menu "Ora si Timezone" \
        "timedatectl status"                                        "starea completa" \
        "date '+  Data: %d/%m/%Y  |  Ora: %H:%M:%S  |  Timezone: %Z'" \
                                                                    "data si ora" \
        "timedatectl list-timezones | grep -iE 'bucharest|chisinau'" \
                                                                    "timezone Romania/Moldova" \
        "date -d '+30 days' +'Peste 30 zile: %d %B %Y' 2>/dev/null || date -v+30d +'%d/%m/%Y' 2>/dev/null" \
                                                                    "data peste 30 de zile"
}

cap13_menu() {
    while true; do
        header; banner "Capitolul 13 — Serverul NTP" "⏰"
        echo -e "  ${C}1.${N} Ce este NTP          ${DIM}(Stratum, servere publice)${N}"
        echo -e "  ${C}2.${N} Configurare NTP       ${DIM}(timesyncd, chrony)${N}"
        echo -e "  ${C}3.${N} Gestionarea orei      ${DIM}(date, timedatectl, hwclock)${N}"
        echo -e "  ${M}s.${N} Sandbox Terminal       ${DIM}(tasteaza orice comanda)${N}"
        echo -e "  ${R}0.${N} Inapoi"
        echo ""
        echo -e "  ${BC}${S}${N}"
        echo -ne "  Alegeti (0-3/s): "; read -r o
        case $o in
            1)cap13_1;; 2)cap13_2;; 3)cap13_3;;
            s|S)sandbox;; 0)return;; *)invalid;;
        esac
    done
}

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  MENIU PRINCIPAL
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

show_intro() {
    clear
    echo ""
    echo -e "${BC}  ╔${L}╗${N}"
    echo -e "${BC}  ║${BG_HEADER}${W}${BOLD}                                                                  ${N}${BC}║${N}"
    echo -e "${BC}  ║${BG_HEADER}${W}${BOLD}       ██╗     ██╗███╗   ██╗██╗   ██╗██╗  ██╗                   ${N}${BC}║${N}"
    echo -e "${BC}  ║${BG_HEADER}${W}${BOLD}       ██║     ██║████╗  ██║██║   ██║╚██╗██╔╝                   ${N}${BC}║${N}"
    echo -e "${BC}  ║${BG_HEADER}${W}${BOLD}       ██║     ██║██╔██╗ ██║██║   ██║ ╚███╔╝                    ${N}${BC}║${N}"
    echo -e "${BC}  ║${BG_HEADER}${C}${BOLD}       ██║     ██║██║╚██╗██║██║   ██║ ██╔██╗                    ${N}${BC}║${N}"
    echo -e "${BC}  ║${BG_HEADER}${C}${BOLD}       ███████╗██║██║ ╚████║╚██████╔╝██╔╝ ██╗                   ${N}${BC}║${N}"
    echo -e "${BC}  ║${BG_HEADER}${C}${BOLD}       ╚══════╝╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝   Curs v2.0     ${N}${BC}║${N}"
    echo -e "${BC}  ║${BG_HEADER}${W}${BOLD}                                                                  ${N}${BC}║${N}"
    echo -e "${BC}  ╠${L}╣${N}"
    printf   "${BC}  ║${N}  ${DIM}%-64s${BC}║${N}\n" "Costel Iacob  ·  Anul I ID  ·  Grupa 106"
    printf   "${BC}  ║${N}  ${DIM}%-64s${BC}║${N}\n" "Capitole: 3, 4, 5, 6, 7, 8, 12, 13  (InfoAcademy Linux)"
    echo -e "${BC}  ╚${L}╝${N}"
    echo ""
    echo -e "  ${G}Apasati ENTER pentru a continua...${N} "
    read -r
}

main_menu() {
    show_intro
    while true; do
        header
        echo ""
        echo -e "  ${W}${BOLD}Selectati un capitol:${N}"
        echo ""
        echo -e "  ${BC}┌──────────────────────────────────────────────────────────────┐${N}"
        echo -e "  ${BC}│${N}  ${C}${BOLD}1.${N}  Cap 3  — Sistemul de Fisiere        ${DIM}(ls, chmod, find, tar)${N}"
        echo -e "  ${BC}│${N}  ${C}${BOLD}2.${N}  Cap 4  — Utilizatori si Permisiuni  ${DIM}(useradd, passwd, groups)${N}"
        echo -e "  ${BC}│${N}  ${C}${BOLD}3.${N}  Cap 5  — Procese si Semnale         ${DIM}(ps, kill, bg/fg, systemd)${N}"
        echo -e "  ${BC}│${N}  ${C}${BOLD}4.${N}  Cap 6  — Shell Scripting            ${DIM}(variabile, bucle, functii)${N}"
        echo -e "  ${BC}│${N}  ${C}${BOLD}5.${N}  Cap 7  — Administrarea Software     ${DIM}(apt, dpkg, hardware)${N}"
        echo -e "  ${BC}│${N}  ${C}${BOLD}6.${N}  Cap 8  — Configurarea Retelei       ${DIM}(ip, ping, dns, porturi)${N}"
        echo -e "  ${BC}│${N}  ${C}${BOLD}7.${N}  Cap 12 — Serverul E-mail            ${DIM}(Postfix, SMTP, IMAP)${N}"
        echo -e "  ${BC}│${N}  ${C}${BOLD}8.${N}  Cap 13 — Serverul NTP               ${DIM}(chrony, timedatectl)${N}"
        echo -e "  ${BC}├──────────────────────────────────────────────────────────────┤${N}"
        echo -e "  ${BC}│${N}  ${M}${BOLD}s.${N}  Sandbox Terminal                    ${DIM}(ruleaza orice comanda)${N}"
        echo -e "  ${BC}├──────────────────────────────────────────────────────────────┤${N}"
        echo -e "  ${BC}│${N}  ${R}${BOLD}0.${N}  IESIRE"
        echo -e "  ${BC}└──────────────────────────────────────────────────────────────┘${N}"
        echo ""
        echo -ne "  ${BC}►${N} Alegeti optiunea: "
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
            s|S) sandbox  ;;
            0)
                clear
                echo ""
                echo -e "${BC}  ╔${L}╗${N}"
                echo -e "${BC}  ║${BG_OK}${BG}${BOLD}   ✔  La revedere! Spor la invatat Linux!                       ${N}${BC}║${N}"
                echo -e "${BC}  ╠${L}╣${N}"
                printf  "${BC}  ║${N}  ${DIM}%-64s${BC}║${N}\n" "Costel Iacob  |  Anul I ID  |  Grupa 106"
                echo -e "${BC}  ╚${L}╝${N}"
                echo ""
                exit 0
                ;;
            *) invalid ;;
        esac
    done
}

# ── Start ──────────────────────────────────────────────────────────
main_menu
