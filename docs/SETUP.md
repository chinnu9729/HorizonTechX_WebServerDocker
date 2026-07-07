# Docker Web Server - Installation & Setup Guide

## System Requirements

- Ubuntu 22.04 LTS or AWS EC2
- Docker 24.x or later
- Docker Compose 2.x
- Minimum 2 GB RAM

---

## Install Docker

```bash
sudo apt update
sudo apt install docker.io -y
sudo systemctl enable docker
sudo systemctl start docker
```

---

## Configure Docker

```bash
sudo usermod -aG docker $USER
newgrp docker
docker ps
```

---

## Verify Installation

```bash
docker --version
docker compose version
```

---

## Clone Repository

```bash
git clone https://github.com/chinnu9729/HorizonTechX_WebServerDocker.git

cd HorizonTechX_WebServerDocker
```

---

## Build Docker Image

```bash
docker build -t horizontechx-web-server:1.0 .
```

---

## Run Container

```bash
docker run -d -p 80:80 --name web-server horizontechx-web-server:1.0
```

---

## Access Application

```
http://http://100.48.5.101

or

http://100.48.5.101
```

---

## Verification

- Docker installed
- Image built
- Container running
- Web page accessible
- Health checks working
