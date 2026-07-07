# HorizonTechX - Web Server using Docker

## 📋 Project Overview

This project demonstrates Docker containerization fundamentals by deploying and managing a web server using Docker and Docker Compose.

## 🎯 Learning Objectives

- Learn Docker containerization fundamentals
- Deploy and manage a web server using Docker
- Understand container lifecycle and commands
- Monitor container health and troubleshoot issues
- Explore container-based deployment best practices

## 📁 Project Structure

```
HorizonTechX_WebServerDocker/
├── Dockerfile
├── docker-compose.yml
├── nginx.conf
├── app/
│   └── index.html
├── docs/
└── README.md
```

## 🚀 Quick Start

### Prerequisites

- Docker 24+
- Docker Compose 2+
- Ubuntu 22.04 or AWS EC2

### Clone Repository

```bash
git clone https://github.com/chinnu9729/HorizonTechX_WebServerDocker.git
cd HorizonTechX_WebServerDocker
```

### Build Docker Image

```bash
docker build -t horizontechx-web-server:1.0 .
```

### Run Container

```bash
docker run -d -p 80:80 --name web-server horizontechx-web-server:1.0
```

### Access the Web Server

```
http://localhost
http://YOUR_EC2_PUBLIC_IP
```

## 🛠️ Technologies Used

- Docker
- Docker Compose
- Nginx
- Ubuntu
- AWS EC2
- Git
- GitHub

## 📚 Features

- Dockerized Nginx Web Server
- Docker Compose Support
- Custom Docker Image
- Container Monitoring
- Production Best Practices
- GitHub Version Control
- Docker Hub Image

## 👩‍💻 Author

**Vancha Rishika**

GitHub: https://github.com/chinnu9729
