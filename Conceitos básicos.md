# Configuração de VPC, EC2 e Nginx na AWS

## 1. VPC (Virtual Private Cloud)
O **VPC** permite criar uma rede virtual isolada na AWS onde você pode controlar totalmente o tráfego de entrada e saída. Dentro da VPC, você pode criar sub-redes públicas e privadas para organizar e proteger suas instâncias EC2 e outros recursos.

- **Componentes principais**:
  - **Sub-redes**: Dividem sua rede em zonas de disponibilidade (AZs) para melhorar a disponibilidade e reduzir falhas.
  - **Internet Gateway**: Permite que instâncias em sub-redes públicas se comuniquem com a internet.
  - **Route Tables**: Controla o tráfego dentro da VPC, definindo como ele deve ser roteado entre as sub-redes e para a internet.

- **Objetivo**: Prover isolamento e segurança para seus recursos, garantindo que apenas instâncias específicas tenham acesso à internet ou outras instâncias.

## 2. EC2 (Elastic Compute Cloud)
O **EC2** é um serviço de computação que permite criar instâncias de máquinas virtuais (servidores) na nuvem da AWS. Essas instâncias podem rodar sistemas operacionais como Linux, Windows, etc., e são a base para hospedar suas aplicações.

- **Funções principais**:
  - **Escalabilidade**: Você pode iniciar ou parar instâncias conforme necessário para atender a diferentes demandas de tráfego.
  - **Tipos de instância**: A AWS oferece diversos tipos de instâncias (t3, m5, c5, etc.) para diferentes necessidades de desempenho e custo.
  - **Segurança**: As instâncias são protegidas por **Security Groups**, que funcionam como firewalls controlando o tráfego de rede.

- **Objetivo**: Hospedar e executar suas aplicações, sites e outros serviços na nuvem de forma escalável e segura.

## 3. Nginx
O **Nginx** é um servidor web e proxy reverso popular para balanceamento de carga, cache de conteúdo e gerenciamento de tráfego. Quando instalado em uma instância EC2, o Nginx pode ser usado para servir conteúdo estático, redirecionar requisições HTTP/HTTPS e balancear carga entre várias instâncias EC2.

- **Funções principais**:
  - **Servidor Web**: Serve arquivos estáticos como HTML, CSS, imagens, etc.
  - **Proxy Reverso**: Redireciona as requisições para outras instâncias EC2 ou servidores.
  - **Balanceamento de Carga**: Distribui tráfego de rede entre várias instâncias EC2 para melhorar a disponibilidade e performance.

- **Objetivo**: Melhorar a performance e a escalabilidade das suas aplicações, além de aumentar a segurança com redirecionamento de tráfego e autenticação.

## Como Configurar VPC, EC2 e Nginx na AWS

### Passo 1: Criar uma VPC
1. No console da AWS, vá até **VPC** e clique em "Criar VPC".
2. Defina as configurações da VPC (ex: CIDR, sub-redes públicas/privadas, etc.).
3. Crie um **Internet Gateway** e associe-o à VPC para permitir a comunicação com a internet.

### Passo 2: Lançar uma Instância EC2
1. Acesse **EC2** no console da AWS e lance uma nova instância.
2. Escolha o sistema operacional (ex: Ubuntu).
3. Defina o **Security Group** para permitir tráfego na porta 80 (HTTP) e 443 (HTTPS).
4. Faça login na instância usando SSH.

### Passo 3: Instalar e Configurar o Nginx
Após conectar-se à instância EC2, siga os passos abaixo para instalar o Nginx:

```bash
sudo apt update
sudo apt install nginx
sudo systemctl start nginx
sudo systemctl enable nginx
```
