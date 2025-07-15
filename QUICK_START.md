# 🚀 Guia Rápido de Início

## ⚡ Configuração em 5 Minutos

### 1. Pré-requisitos

- Docker e Docker Compose instalados
- Git instalado

### 2. Clone e Configure

```bash
# Clone o projeto
git clone <url-do-repositorio>
cd n8n-queue

# Crie o arquivo de ambiente a partir do exemplo
cp .env.example .env

# Edite o arquivo .env com suas senhas e chaves
nano .env
```

### 3. Inicie o Sistema

```bash
# Inicie todos os serviços
docker compose up -d

# Verifique se está tudo funcionando
docker compose ps
```

### 4. Acesse as Interfaces

- **n8n**: `N8N_EDITOR_BASE_URL`
- **Evolution API**: `SERVER_URL`

Ambas as URLs são configuradas no arquivo `.env`.

## 🔧 Configurações Essenciais

### Variáveis Obrigatórias (altere no .env)

```env
# Senhas e Chaves Obrigatórias (#REQUIRED)
POSTGRES_PASSWORD=your_postgres_password
REDIS_PASSWORD=your_redis_password
N8N_ENCRYPTION_KEY=your_n8n_encryption_key
AUTHENTICATION_API_KEY=your_api_key
```

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
# Ver logs
docker compose logs

# Reiniciar
docker compose down
docker compose up -d
```

### WhatsApp não conecta

- Verifique se o QR Code foi escaneado
- Confirme se o número está no formato correto (com código do país)
- Aguarde alguns segundos após escanear o QR Code

---

**⏱️ Tempo estimado de configuração**: 5-10 minutos
