
## **Configuração do Ambiente e Infraestrutura na AWS**


# 📌  Índice das Etapas

1. **Configuração do Ambiente e Infraestrutura na AWS**
2. **Implantação do Servidor Web e Automação de Monitoramento**
3. **Criação de Sistema de Monitoramento e Notificação**
4. **Testes, Documentação e Desafios de Automação**


### Passo 1.1: Criar a VPC

- Acesse o Console de Gerenciamento da AWS e vá até o serviço **Amazon VPC**.
- Crie uma nova **VPC** com o CIDR Block desejado, por exemplo: `10.0.0.0/16`.
### Passo 1.2: Criar Sub-redes Públicas e Privadas, e Tabelas de Roteamento
- Crie **duas sub-redes públicas** e **duas sub-redes privadas** em diferentes **zonas de disponibilidade (AZs)**.
- **Sub-redes públicas**: terão acesso à Internet por meio de um **Internet Gateway**.
- **Sub-redes privadas**: não terão acesso direto à Internet, mas poderão se comunicar com a Internet por meio de um **NAT Gateway** (se necessário).
Para garantir que o Nginx está rodando corretamente, use:
- Crie uma **tabela de roteamento** para cada sub-rede:
  - Para as **sub-redes públicas**, associe a tabela de roteamento ao **Internet Gateway**, garantindo que as sub-redes públicas tenham acesso à Internet.
  - Para as **sub-redes privadas**, associe a tabela de roteamento ao **NAT Gateway**, garantindo que as sub-redes privadas possam acessar a Internet de forma segura.

### Passo 1.3: Associar Tabelas de Roteamento às Sub-redes
- Após criar as tabelas de roteamento, associe cada uma delas à sub-rede correspondente, garantindo que as sub-redes públicas possam acessar a Internet diretamente e que as privadas possam acessar a Internet por meio do NAT Gateway (se configurado).

---
<img src="https://github.com/user-attachments/assets/cac098c5-cb6d-4617-83eb-60684ed7777b" alt="Texto alternativo" width="400" />
<img src="https://github.com/user-attachments/assets/65aa7a8d-5b44-4388-b549-76426b8761ef" alt="Texto alternativo" width="400" />
<img src="https://github.com/user-attachments/assets/6c2d3d54-dc21-4f78-974b-c6550b80fde2" alt="Texto alternativo" width="400" />
<img src="https://github.com/user-attachments/assets/ae20d062-fa04-4493-a879-b7002d5f947e" alt="Texto alternativo" width="400" />

---
### Fluxo:
<img src="https://github.com/user-attachments/assets/e9e101da-83f7-4ce7-9f16-85237b9d44e0" alt="Imagem" width="400" />

---
### Passo 1.1.1: Criar a Instância EC2
- Acesse o Console de Gerenciamento da AWS e vá até o serviço **EC2**.
- Clique em **Launch Instance** e escolha a **imagem de máquina** (AMI) desejada: **Ubuntu** ou **Amazon Linux 2023**.
- Selecione o tipo de instância, como **t2.micro** (para testes).

### Passo 1.1.2: Configurar a Instância
- Escolha a **VPC** que você criou na etapa anterior e associe a instância a uma **sub-rede pública**.
- Certifique-se de configurar o **grupo de segurança** para permitir o acesso nas portas **22 (SSH)** e **80 (HTTP)**, para acesso remoto e via navegador.

### Passo 1.1.3: Criar e Baixar a Chave SSH
- Crie uma **chave SSH** para acessar a instância EC2.
- Faça o download do arquivo da chave (**.pem**), pois você precisará dela para se conectar à instância.

### Passo 1.1.4: Lançar a Instância
- Revise as configurações e clique em **Launch** para iniciar a instância EC2.
<img src="https://github.com/user-attachments/assets/f78a622e-0385-4e92-b001-799a37d377f2" alt="Imagem 3" width="400" />
<img src="https://github.com/user-attachments/assets/77fc3712-d94b-4311-9334-459e12e9a57e" alt="Imagem 2" width="400" />

---

### Redes:
<img src="https://github.com/user-attachments/assets/698421d2-31b3-45be-9b0e-96baf6b4ef93" alt="Texto alternativo" width="400" />

---
##  Etapa 2: Configuração do Servidor Web (Nginx)

### 2.1 Acessar a Instância via SSH

Para configurar o servidor web, precisa acessar a instância EC2 pela linha de comando via SSH.
### Passo 2.1.1: Conectar-se à Instância EC2
- No terminal local, utilize o seguinte comando SSH para acessar a instância. Lembre-se de substituir o **[Caminho_da_chave.pem]** pelo caminho correto do arquivo da chave SSH que você baixou e **[IP_da_instância]** pelo IP público da sua instância EC2:

```bash
ssh -i /caminho/para/chaveprojeto.pem ubuntu@3.92.15.199
```

---

### 📌 Instalar o Nginx
Já dentro da instância, execute:
```bash
sudo apt install nginx -y
```
ou 
```bash
sudo apt update && sudo apt install nginx -y
```
### Iniciar o Nginx
Após a instalação, inicie o Nginx:

```bash
sudo systemctl start nginx
```
A partir daqui o Nginx já deve estar funcionando dentro da instância criada e pode ser acessado através do navegador com o IP público.

<img src="https://github.com/user-attachments/assets/b4aefdd7-ef30-4051-ad5c-f9329eee2b56" alt="Texto Alternativo" width="400" />

### 📌  Etapa 4: Criar o Site HTML

Agora que o servidor Nginx está configurado, vamos criar a página HTML que será exibida no seu servidor.

### Passo 4.1: Criar o Arquivo HTML

Crie o arquivo HTML no diretório padrão do Nginx com o comando:

```bash
sudo nano /var/www/html/index.html
```
### Transferir o Arquivo do Diretório Local para a Instância EC2
```bash
scp -i chave01.pem -r /home/marjorie/Nginx/site ubuntu@IP_PUBLICO_DA_EC2:/home/ubuntu/
```

### juste as permissões:
```bash
sudo chown -R www-data:www-data /var/www/html/projetosite
sudo chmod -R 755 /var/www/html/site

```

### 📌 Configurar o Nginx
Após a transferência dos arquivos, edite o arquivo de configuração do Nginx para apontar para o diretório onde os arquivos do seu site estão armazenados:
```bash
sudo nano /etc/nginx/sites-available/default
```
💡 Dica: Dentro do arquivo, altere a linha root /var/www/html; para o diretório correto onde seu site está localizado.

### Testar e Reiniciar o Nginx
Verifique se a configuração do Nginx está correta:

```bash
sudo nginx -t
```
### Reinicie o Nginx:
```bash
sudo systemctl restart nginx
```
### Verificar o Status do Nginx
Para garantir que o Nginx está rodando corretamente, use:
```bash
sudo systemctl status nginx

```
<img src="https://github.com/user-attachments/assets/5ed1981e-aaad-4315-95dd-a6e565f23f0d" alt="Descrição da Imagem" width="400">

###  Habilitar o Nginx para Inicialização Automática
```bash
sudo systemctl enable nginx

```

### Site 
<img src="https://github.com/user-attachments/assets/a1a11a29-ee46-4c31-89a0-720df0475e8c" alt="Imagem 4" width="400"/>
<img src="https://github.com/user-attachments/assets/64ce1dc4-33b2-413c-9185-dde97f3d1971" alt="Imagem 1" width="400"/>
<img src="https://github.com/user-attachments/assets/f1285107-2fbc-48bb-8a69-022478ff4d3a" alt="Imagem 3" width="400"/>
<img src="https://github.com/user-attachments/assets/ca9615ed-335e-458e-9f3e-a5383fde2992" alt="Imagem 2" width="400"/>

---
### Passo 3.1: Criar o Script de Monitoramento
Crie o arquivo de script no seu servidor. No seu terminal SSH, crie um arquivo de script, como
```bash
nano monitor_site.sh
```
### Adicione o conteúdo do script. Aqui está um exemplo de script que verifica se o site está respondendo e envia uma notificação via Discord:
```bash
#!/bin/bash
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
    TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")  # Data e hora exata
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
    TIMESTAMP=$(date "+%d/%m/%Y %H:%M:%S")  # Formato de data e hora BR (dia/mês/ano hora:min:seg)
    
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



```

### Torne o script executável:
```bash
chmod +x monitor_site.sh
```
### Passo 3.2: Agendar a Execução do Script
Para rodar o script periodicamente, você pode usar o cron no Linux. O cron permite que você agende a execução de comandos ou scripts em intervalos regulares.

1.Edite o arquivo de configuração do cron:
```bash
crontab -e
```
2.Adicione uma linha para rodar o script a cada 1 minuto:

```bash
* * * * * /caminho/para/monitor_site.sh
```

#### Imagem da Notificação do Site no Discord
<img src="https://github.com/user-attachments/assets/f6935e8e-58bd-4381-9a4f-493156dc115c" alt="Notificação do site no Discord" width="500" />









