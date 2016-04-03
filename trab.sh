#!/bin/bash
#Alunos: Daniel Luz e Bruno Miguel
#Backup de dados importantes
#COMECO

TEMPO=`date +%b-%d-%y`
# Est é o comando que vai adicionar a data ao arquivo backup.

ARQUIVO=backup-$TEMPO.tar.bz2
# Definindo o formato do arquivo de backup

SRC_DIR=/home/$USER/Documents
# Path do local fonte para o backup

DES_DIR=/media/meubackup
# Path de destino

#criar diretorio para dispositivo externo
if [ -d $DES_DIR ]; then
echo "Diretorio já existe"
else
echo "Criando diretório"
mkdir $DES_DIR
fi


#montando dispositivo
sudo mount -t vfat /dev/sdb1 $DES_DIR  

# se estiver em ntfs
sudo mount -t ntfs-3g /dev/sdb1 $DES_DIR
#verificando se está ou não montado
if [ -z $DES_DIR ];then
echo "Não montou, finalizando ... "
exit 1
else

#Deletar arquivos mais velhos que 15 dias
find $DES_DIR -mtime +15 -type f -delete


#    ./sd1/meubackup diretório do backup
#    -mtime +15 - mais que 15 dias
#    -type f some arquivos
#    -delete - remover

echo "Gerando backup"
tar -cpzf $DES_DIR/$ARQUIVO $SRC_DIR
echo "Backup criado com sucesso"
fi

# ------------------------------------------------- #

# Adicionar horário usando contrab -e para abrir o arquivo em editor
#LINUX CONTRAB FORMAT é = MIN HOUR DOM MON DOW CMD

#crontab -e
#00 03 * * * /bin/bash /trab.sh
# adiciona no contrab o horário que o script vai rodar

#    00 Minutos
#    03 – 3AM
#    *– Todo Dia
#    *– Todo Mês
#    *– Todos os dias da Semana

# ------------------------------------------------- #
#FIM
