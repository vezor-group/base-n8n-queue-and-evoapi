-- Create databases for Evolution API and n8n
CREATE DATABASE "evolution-app";
CREATE DATABASE "n8n";

-- Connect to the n8n database to create the extension
\c n8n;
CREATE EXTENSION IF NOT EXISTS vector;