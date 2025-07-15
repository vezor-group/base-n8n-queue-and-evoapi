# Sistema de Automação n8n + Evolution API

## 📋 Descrição do Projeto

Este projeto implementa uma solução completa de automação de processos utilizando **n8n** (plataforma de automação de workflows) integrada com **Evolution API** (API para WhatsApp Business). O sistema permite criar automações complexas que interagem com WhatsApp, incluindo envio de mensagens, processamento de respostas e integração com diversos serviços.

## 🏗️ Arquitetura do Sistema

O sistema é composto pelos seguintes componentes:

### 🔧 **n8n (Modo Fila)** - Plataforma de Automação
- **n8n-editor**: Interface web para criação e gerenciamento de workflows
- **n8n-webhook**: Serviço para receber webhooks externos
- **n8n-worker**: Processador de workflows em background

### 📱 **Evolution API** - Integração WhatsApp
- API REST para gerenciamento de instâncias do WhatsApp
- Suporte a múltiplas conexões WhatsApp
- Webhooks para receber mensagens em tempo real

### 🗄️ **Banco de Dados**
- **PostgreSQL** com extensão pgvector para armazenamento de dados
- **Redis** para cache e filas de processamento

## 🚀 Instalação e Configuração

### Pré-requisitos
- Docker e Docker Compose instalados
- Porta 5678 disponível (n8n)
- Porta 8080 disponível (Evolution API)

### Passo a Passo

1. **Clone o repositório**
    ```bash
    git clone <url-do-repositorio>
    cd n8n-queue
    ```

2. **Configure as variáveis de ambiente**
    ```bash
    # Copie os arquivos de exemplo
    cp evolution.env.example evolution.env
    cp .env.example .env

    # entre nos arquivos .env e evolution.env para editá-los
    nano .env
    nano evolution.env
    ```

    As variáveis que tiverem acompanhadas do comentário   ***`#Change`*** ao seu lado deve ser mudada conforme as necessidades do projeto.


5. **Inicie os serviços**
    ```bash
    docker-compose up -d
    ```

6. **Verifique se todos os serviços estão rodando**
    ```bash
    docker-compose ps
    ```

## 📖 Manual de Uso

### Acessando o n8n e a Evolution API

**Abra o navegador** e acesse as urls passadas nas variáveis de ambiente:
  - **.env**: `N8N_EDITOR_BASE_URL`
  - **evolution.env**: `SERVER_URL`

## 🔧 Manutenção

### Logs dos Serviços
```bash
# Ver logs do n8n
docker-compose logs n8n-editor

# Ver logs da Evolution API
docker-compose logs evolution-api

# Ver logs do PostgreSQL
docker-compose logs postgres
```

### Backup dos Dados
```bash
# Backup do PostgreSQL
docker-compose exec postgres pg_dump -U postgres evolution-app > backup.sql

# Backup dos volumes
docker run --rm -v n8n-queue_postgres-data:/data -v $(pwd):/backup alpine tar czf /backup/postgres-backup.tar.gz -C /data .
```

### Atualização do Sistema
```bash
# Atualizar imagens
docker-compose pull

# Parar os serviços
docker-compose down

# Reiniciar serviços
docker-compose up -d
```

## 🛠️ Solução de Problemas

### Problema: n8n não acessível
- Verifique se a porta 5678 está livre
- Confirme se o container está rodando: `docker-compose ps`
- Verifique os logs: `docker-compose logs n8n-editor`

### Problema: Evolution API não responde
- Verifique se a porta 8080 está livre
- Confirme as configurações no `evolution.env`
- Verifique os logs: `docker-compose logs evolution-api`

### Problema: WhatsApp não conecta
- Verifique se o QR Code foi escaneado corretamente
- Confirme se o número está no formato correto (com código do país)
- Verifique se a instância foi criada corretamente

## 📄 Licença

Este projeto é proprietário e confidencial. Todos os direitos reservados.

---

**Versão**: 1.0

**Última atualização**: 14/07/2025
