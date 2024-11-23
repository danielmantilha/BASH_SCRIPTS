#!/usr/bin/env bash
#--------------------------------------------------------
# Função: Lista diretórios e arquivos
# salvos em cache e deleta os diretorios.
#--------------------------------------------------------
# Criador: Daniel Mantilha
#--------------------------------------------------------
# Versão: 1.0
#--------------------------------------------------------

DEBUGAR=0

if [ "$1" = "-d" ]; then
    DEBUGAR=1
    set -x
    echo "Modo de depuração ativado."
fi

MENSAGEM=" 
        $(basename "$0") - OPÇÕES DO PROGRAMA

            -s para mostrar o tamanho ocupado por caches no /var/cache
            -h para mais ajuda
            -l lista todos os diretórios no /var/cache
            -f deleta todos os arquivos de cache (PODE DANIFICAR O SISTEMA)
            -k remove cache do flatpak
            -p remove packages e repositorios não usados no Arch Linux
            -g remove os logs do /var/log
            -v mostra o tamanho do /var
            -d debug mode
        "

#echo "$MENSAGEM" && exit

#VARIAVEIS
SHOW_SIZE=$(sudo du -sh /var/cache) #Mostra o tamanho do cache em /var
LIST_ALL=$(sudo du -sh /var/*) #Lista todos os dirétorios e seus tamanhos em cache no /var
FULL_D=$(sudo rm -rf /var/cache/*) #Deleta absolutamente todos os diretórios dentro de cache
REMOVE_UNUSED=$(sudo flatpak remove --unused 2>/dev/null) #Remove tudo que não está sendo usado na pasta do flatpak
REMOVE_UNUSED_PAC=$(sudo pacman -Sc --noconfirm 2>/dev/null) #Remove tudo que não está sendo usado pelo PACMAN
REMOVE_LOGS=$(sudo rm -rf /var/log/*) #Remove Todos os Logs do sistemas
SHOW_VAR=$(sudo du -sch /var) #Mostra o tamanho do /var

#CASE 
case $1 in

    -h) echo "$MENSAGEM"            ;;
    -s) echo "$SHOW_SIZE"           ;;
    -l) echo "$LIST_ALL"            ;;
    -f) echo "$FULL_D"              ;;
    -k) echo "$REMOVE_UNUSED"       ;;
    -p) echo "$REMOVE_UNUSED_PAC"   ;;
    -g) echo "$REMOVE_LOGS"         ;;
    -v) echo "$SHOW_VAR"            ;;

esac

if [ "$DEBUGAR" -eq 0 ]; then
    set +x
    echo "Modo de depuração desativado."
fi
