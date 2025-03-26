
## **Configuração do Ambiente e Infraestrutura na AWS**


# 📍 Índice das Etapas

1. **Configuração do Ambiente e Infraestrutura na AWS**
2. **Implantação do Servidor Web e Automação de Monitoramento**
3. **Criação de Sistema de Monitoramento e Notificação**
4. **Testes, Documentação e Desafios de Automação**

.0 Criar uma VPC com 2 Sub-redes Públicas e 2 Privadas

Nesta etapa, vamos configurar a infraestrutura básica na AWS criando uma VPC (Virtual Private Cloud) com sub-redes públicas e privadas.

### Passo 1.1: Criar a VPC

- Acesse o Console de Gerenciamento da AWS e vá até o serviço **Amazon VPC**.
- Crie uma nova **VPC** com o CIDR Block desejado, por exemplo: `10.0.0.0/16`.
### Passo 1.2: Criar Sub-redes Públicas e Privadas, e Tabelas de Roteamento
- Crie **duas sub-redes públicas** e **duas sub-redes privadas** em diferentes **zonas de disponibilidade (AZs)**.
- **Sub-redes públicas**: terão acesso à Internet por meio de um **Internet Gateway**.
- **Sub-redes privadas**: não terão acesso direto à Internet, mas poderão se comunicar com a Internet por meio de um **NAT Gateway** (se necessário).

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
<img src="https://github.com/user-attachments/assets/698421d2-31b3-45be-9b0e-96baf6b4ef93" alt="Texto alternativo" width="400" />








