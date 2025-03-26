#!/bin/bash

# Defina as variáveis
URL="http://3.92.15.199"   # IP público da sua EC2
WEBHOOK_URL="https://discord.com/api/webhooks/1352682870124187698/nFnBeaAeKRICnG0ksI25zqpGu6ZCmVMVgz3zxFPs1pACvJwB3uwuNq8AMFlselzeWDB5"  # Webhook do Discord
PUBLIC_IP="3.92.15.199"    # IP público da sua EC2
LOG_FILE="/var/log/site_script.log"  # Caminho do log
TZ="America/Sao_Paulo"  # Fuso horário para o Brasil (ajuste conforme necessário)

# Configura o fuso horário corretamente
export TZ=$TZ

# Criar o arquivo de log se não existir
if [ ! -f "$LOG_FILE" ]; then
    sudo touch $LOG_FILE
    sudo chmod 666 $LOG_FILE
fi

# Função para registrar logs
log_message() {
    TIMESTAMP=$(TZ="America/Sao_Paulo" date "+%Y-%m-%d %H:%M:%S")  # Hora exata em Brasília
    echo "$TIMESTAMP - $1" >> $LOG_FILE
}

# Função para enviar mensagem ao Discord
send_notification() {
    curl -X POST -H "Content-Type: application/json" -d '{
        "content": "'"$1"'"
    }' $WEBHOOK_URL
}

# Loop infinito para monitorar o site
while true; do
    TIMESTAMP=$(TZ="America/Sao_Paulo" date "+%d/%m/%Y %H:%M:%S")  # Formato de data e hora BR (dia/mês/ano hora:min:seg)
    
    # Verifica o status do site
    HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" $URL)

    if [ "$HTTP_STATUS" -eq 200 ]; then
        # Mensagem quando o site está no ar
        MESSAGE="🎉 **Seu site está no ar!** 🎉\n\n🌐 O site com IP **$PUBLIC_IP** está funcionando corretamente.\n✅ Status HTTP: **200**\n⏰ Verificado em: **$TIMESTAMP**."
        log_message "Site no ar - Status: 200"
    else
        # Mensagem quando o site está fora do ar
        MESSAGE="⚠️ **Alerta!** Seu site está fora do ar! ⚠️\n\n🚨 O site **$URL** (IP: $PUBLIC_IP) não está respondendo corretamente.\n❌ Status HTTP: **$HTTP_STATUS**\n⏰ Verificado em: **$TIMESTAMP**."
        log_message "Site fora do ar - Status: $HTTP_STATUS"
    fi

    # Envia a notificação para o Discord
    send_notification "$MESSAGE"

    # Espera 60 segundos antes de rodar de novo
    sleep 60
done
