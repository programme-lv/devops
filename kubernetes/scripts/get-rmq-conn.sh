#!/usr/bin/bash

RABBITMQ_NAME="rmq-cluster"
NAMESPACE="default"

# Get the service name
SERVICE_NAME="${RABBITMQ_NAME}"

# Get the default port for AMQP
PORT=5672

# Get the username and password from Kubernetes secrets
USERNAME=$(kubectl get secret ${RABBITMQ_NAME}-default-user -n ${NAMESPACE} -o jsonpath="{.data.username}" | base64 --decode)
PASSWORD=$(kubectl get secret ${RABBITMQ_NAME}-default-user -n ${NAMESPACE} -o jsonpath="{.data.password}" | base64 --decode)

# Print the connection string
echo "amqp://${USERNAME}:${PASSWORD}@${SERVICE_NAME}.${NAMESPACE}.svc.cluster.local:${PORT}"
