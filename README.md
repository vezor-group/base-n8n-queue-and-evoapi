# Sistema de Automação n8n + Evolution API

## 📋 Descrição do Projeto

Este projeto implementa uma solução completa de automação de processos utilizando **n8n** (plataforma de automação de workflows) integrada com **Evolution API** (API para WhatsApp Business). O sistema permite criar automações complexas que interagem com WhatsApp, incluindo envio de mensagens, processamento de respostas e integração com diversos serviços.

## ⚡ Start Rápido

Se quiser fazer o start rápido, acesse: [QUICK_START.md](QUICK_START.md)

## 🏗️ Arquitetura do Sistema

O sistema é composto pelos seguintes componentes principais:

### 🔧 **n8n (Modo Fila)** - Plataforma de Automação

- **n8n-editor**: Interface web para criação e gerenciamento de workflows (porta 5678)
- **n8n-webhook**: Serviço para receber webhooks externos
- **n8n-worker**: Processador de workflows em background com concorrência configurável

### 📱 **Evolution API** - Integração WhatsApp

- API REST para gerenciamento de instâncias do WhatsApp (porta 8080)
- Suporte a múltiplas conexões WhatsApp
- Webhooks para receber mensagens em tempo real
- Armazenamento persistente de instâncias

### 🗄️ **Banco de Dados**

- **PostgreSQL 16** com extensão pgvector para armazenamento de dados e vetores
- **Redis 7** para cache, filas de processamento e sessões
- Bancos separados: `n8n` e `evolution-app`

## 🚀 Instalação e Configuração

### Pré-requisitos

- Docker e Docker Compose instalados
- Porta 5678 disponível (n8n Editor)
- Porta 8080 disponível (Evolution API)

### Passo a Passo

1. **Clone o repositório**

   ```bash
   git clone <url-do-repositorio>
   cd base-n8n-queue-and-evoapi
   ```

2. **Configure as variáveis de ambiente**

   ```bash
   # Copie o arquivo de exemplo para criar seu ambiente
   cp .env.example .env

   # Edite as configurações necessárias
   nano .env
   ```

   **Variáveis obrigatórias** (marcadas com `#REQUIRED`):
   - `N8N_ENCRYPTION_KEY`: Chave de criptografia do n8n (gere uma chave segura)
   - `N8N_HOST`: Domínio do seu n8n
   - `AUTHENTICATION_API_KEY`: Chave de autenticação da Evolution API
   - `SERVER_URL`: URL do seu servidor Evolution API

   **Variáveis opcionais** podem ser ajustadas conforme sua necessidade.

3. **Inicie os serviços**

   ```bash
   docker compose up -d
   ```

4. **Verifique se todos os serviços estão rodando**
   ```bash
   docker compose ps
   ```

## 📖 Manual de Uso

### Acessando os Serviços

Após iniciar os containers, acesse:

- **n8n Editor**: `http://localhost:5678` (ou URL configurada em `N8N_EDITOR_BASE_URL`)
- **Evolution API**: `http://localhost:8080` (ou URL configurada em `SERVER_URL`)

### Configuração Inicial

1. **n8n**: Acesse o editor e configure seu primeiro usuário admin
2. **Evolution API**: Use a API para criar e gerenciar instâncias do WhatsApp

## 🔧 Manutenção

### Logs dos Serviços

```bash
# Ver logs de todos os serviços
docker compose logs

# Ver logs específicos
docker compose logs n8n-editor
docker compose logs n8n-webhook  
docker compose logs n8n-worker
docker compose logs evolution-api
docker compose logs postgres
docker compose logs redis

# Seguir logs em tempo real
docker compose logs -f n8n-editor
```

### Backup dos Dados

```bash
# Backup do banco n8n
docker compose exec postgres pg_dump -U postgres n8n > backup-n8n.sql

# Backup do banco evolution-app
docker compose exec postgres pg_dump -U postgres evolution-app > backup-evolution.sql

# Backup completo dos volumes
docker run --rm -v base-n8n-queue-and-evoapi_postgres-data:/data -v $(pwd):/backup alpine tar czf /backup/postgres-backup.tar.gz -C /data .
docker run --rm -v base-n8n-queue-and-evoapi_n8n-data:/data -v $(pwd):/backup alpine tar czf /backup/n8n-backup.tar.gz -C /data .
docker run --rm -v base-n8n-queue-and-evoapi_evolution-instances:/data -v $(pwd):/backup alpine tar czf /backup/evolution-backup.tar.gz -C /data .
```

### Atualização do Sistema

```bash
# Atualizar para as versões mais recentes
docker compose pull

# Reiniciar com novas imagens (preserva dados)
docker compose down
docker compose up -d

# Verificar se todos os serviços estão saudáveis
docker compose ps
```

## 🛠️ Solução de Problemas

### Problema: n8n não acessível

- Verifique se a porta 5678 está livre: `netstat -tulpn | grep :5678`
- Confirme se o container está rodando: `docker compose ps`
- Verifique os logs: `docker compose logs n8n-editor`
- Aguarde o healthcheck do PostgreSQL e Redis

### Problema: Evolution API não responde

- Verifique se a porta 8080 está livre: `netstat -tulpn | grep :8080`
- Confirme as configurações obrigatórias no `.env`
- Verifique os logs: `docker compose logs evolution-api`
- Confirme se os bancos de dados estão acessíveis

### Problema: Erro de conexão com banco de dados

- Verifique se PostgreSQL está rodando: `docker compose logs postgres`
- Confirme as credenciais no `.env`
- Verifique se os bancos foram criados: `docker compose exec postgres psql -U postgres -l`

### Problema: WhatsApp não conecta

- Verifique se o QR Code foi escaneado corretamente
- Confirme se o número está no formato correto (com código do país)  
- Verifique se a instância foi criada corretamente via API
- Consulte os logs da Evolution API para erros específicos

## 📄 Licença

Este projeto é proprietário e confidencial. Todos os direitos reservados. [LICENSE](LICENSE.txt)

---

**Versão**: 2.0

**Última atualização**: 09/09/2025
