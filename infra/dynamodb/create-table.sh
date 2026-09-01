#!/bin/sh
set -eu

echo "Aguardando DynamoDB Local em ${DYNAMODB_ENDPOINT}..."
i=0
until aws dynamodb list-tables --endpoint-url "${DYNAMODB_ENDPOINT}" --region "${AWS_REGION}" >/dev/null 2>&1; do
  i=$((i + 1))
  if [ "$i" -gt 60 ]; then
    echo "Timeout aguardando DynamoDB Local"
    exit 1
  fi
  sleep 1
done

echo "Criando tabela ${TABLE_NAME} (se não existir)..."
if aws dynamodb describe-table \
  --endpoint-url "${DYNAMODB_ENDPOINT}" \
  --region "${AWS_REGION}" \
  --table-name "${TABLE_NAME}" >/dev/null 2>&1; then
  echo "Tabela ${TABLE_NAME} já existe."
else
  aws dynamodb create-table \
    --endpoint-url "${DYNAMODB_ENDPOINT}" \
    --region "${AWS_REGION}" \
    --table-name "${TABLE_NAME}" \
    --attribute-definitions AttributeName=event_id,AttributeType=S \
    --key-schema AttributeName=event_id,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1
fi

aws dynamodb wait table-exists \
  --endpoint-url "${DYNAMODB_ENDPOINT}" \
  --region "${AWS_REGION}" \
  --table-name "${TABLE_NAME}"

echo "Tabela ${TABLE_NAME} pronta."
