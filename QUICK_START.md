# 🚀 Guia Rápido de Início

## ⚡ Configuração em 5 Minutos

### 1. Pré-requisitos

- Docker instalados
- Git instalado

### 2. Clone e Configure

```bash
# Clone o projeto
git clone <url-do-repositorio>
cd base-n8n-queue-and-evoapi

# Crie o arquivo de ambiente a partir do exemplo
cp .env.example .env
```
Edite o arquivo `.env` com suas senhas e chaves.

### 3. Inicie o Sistema

```bash
# Inicie todos os serviços
docker compose up -d

# Verifique se está tudo funcionando
docker compose ps

# Aguarde os healthchecks (PostgreSQL e Redis devem estar "healthy")
```

### 4. Acesse as Interfaces

- **n8n Editor**: `http://localhost:5678` (ou valor de `N8N_EDITOR_BASE_URL`)
- **Evolution API**: `http://localhost:8080` (ou valor de `SERVER_URL`)

**Primeira configuração**:
- No n8n: Configure seu usuário administrador
- Na Evolution API: Use a API para criar instâncias do WhatsApp

## 🔧 Configurações Essenciais

### Variáveis Obrigatórias (marcadas com #REQUIRED no .env)

```env
# Chave de criptografia do n8n (gere uma chave segura)
N8N_ENCRYPTION_KEY=your_generated_encryption_key

# Domínio onde o n8n será acessado
N8N_HOST=your-domain.com

# Chave de autenticação da Evolution API
AUTHENTICATION_API_KEY=your_authentication_api_key

# URL do servidor Evolution API
SERVER_URL=https://your-evoapi-domain.com
```

**💡 Dica**: As senhas do PostgreSQL e Redis podem ser mantidas como padrão para desenvolvimento local.

## 🆘 Problemas Comuns

### Porta já em uso

```bash
# Verificar portas em uso
netstat -tulpn | grep :5678
netstat -tulpn | grep :8080

# Parar serviços conflitantes ou alterar portas no docker-compose.yml
```

### Containers não iniciam

```bash
# Ver logs de todos os serviços
docker compose logs

# Ver logs específicos
docker compose logs postgres
docker compose logs n8n-editor

# Reiniciar completamente
docker compose down
docker compose up -d
```

### Banco de dados não conecta

```bash
# Verificar se PostgreSQL está healthy
docker compose ps

# Verificar logs do banco
docker compose logs postgres

# Aguardar inicialização completa (pode levar 1-2 minutos)
```

### WhatsApp não conecta

- Verifique se o QR Code foi escaneado corretamente
- Confirme se o número está no formato correto (com código do país)
- Aguarde alguns segundos após escanear o QR Code
- Consulte logs da Evolution API: `docker compose logs evolution-api`
