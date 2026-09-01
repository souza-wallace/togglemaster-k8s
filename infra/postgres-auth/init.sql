-- Schema da tabela api_keys (auth-service)
CREATE TABLE IF NOT EXISTS api_keys (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    key_hash VARCHAR(64) NOT NULL UNIQUE,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Seed: chave fixa para o evaluation-service no ambiente local (Docker Compose)
-- Plaintext: tm_key_local_evaluation_service_dev_only_0001
INSERT INTO api_keys (name, key_hash, is_active)
VALUES (
    'evaluation-service',
    '4214c6ecaf38a91e71e0b42d3dc58ce61caca52f5446434dbb2ac54c32b6e104',
    true
)
ON CONFLICT (key_hash) DO NOTHING;
