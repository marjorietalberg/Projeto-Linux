#!/bin/bash

# Definição das variáveis
URL="http://SEU_IP_PUBLICO"  # Substitua pelo IP real do seu site
WEBHOOK_URL="SEU_WEBHOOK_DISCORD"  # Substitua pelo seu webhook do Discord
LOG_FILE="/var/log/site_script.log"
TZ="America/Sao_Paulo"


export TZ=$TZ

if [ ! -f "$LOG_FILE" ]; then
    sudo touch $LOG_FILE  
    sudo chmod 666 $LOG_FILE  
fi

# Função para registrar mensagens no log
deslog_message() {
    TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
    echo "$TIMESTAMP - $1" >> $LOG_FILE
}


send_notification() {
    curl -X POST -H "Content-Type: application/json" -d '{
        "content": "'$1'"
    }' $WEBHOOK_URL
}


LAST_SENT=""


while true; do
  
    CURRENT_TIME=$(date "+%H:%M")
    

    if [[ "$CURRENT_TIME" != "$LAST_SENT" ]]; then
        LAST_SENT="$CURRENT_TIME"
        
     
        HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" $URL)
        TIMESTAMP=$(date "+%d/%m/%Y %H:%M:%S")

        if [ "$HTTP_STATUS" -eq 200 ]; then
            MESSAGE="🎉 Site online - ⏰ $TIMESTAMP"
            deslog_message "Site no ar - Status: 200"
        else
            MESSAGE="⚠️ Site offline - ⏰ $TIMESTAMP"
            deslog_message "Site fora do ar - Status: $HTTP_STATUS"
            
       
            sudo systemctl restart nginx
            deslog_message "Nginx reiniciado automaticamente"
        fi

        send_notification "$MESSAGE"
    fi
    
    sleep 10  
done
