FROM n8nio/n8n:latest
LABEL maintainer="Allan <allangonzales1221@gmail.com"
EXPOSE 5678
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV N8N_PROTOCOL=http
