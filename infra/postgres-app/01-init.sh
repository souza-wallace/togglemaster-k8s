#!/bin/bash
set -euo pipefail

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    SELECT 'CREATE DATABASE flags_db'
    WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'flags_db')\gexec
    SELECT 'CREATE DATABASE targeting_db'
    WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'targeting_db')\gexec
EOSQL

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname flags_db -f /schemas/flags-schema.sql
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname targeting_db -f /schemas/targeting-schema.sql
