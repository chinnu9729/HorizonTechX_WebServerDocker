# Troubleshooting Guide

## 🐛 Container Won't Start

```bash
docker logs web-server
docker inspect web-server | grep State
```

## 🚪 Port Already in Use

```bash
sudo lsof -i :80
docker run -d -p 8000:80 horizontechx-web-server:1.0
```

## 🌐 Can't Access Web Server

- Check AWS Security Group inbound rules.
- Verify the port mapping:

```bash
docker port web-server
```

- Test connectivity from inside the container:

```bash
docker exec web-server curl localhost
```

---

# 📊 Performance Optimization

## Resource Limits

```bash
docker run -d \
    --memory 256m \
    --cpus 0.5 \
    -p 80:80 \
    horizontechx-web-server:1.0
```

## Multi-stage Builds

Using multi-stage Docker builds helps reduce the final image size.

---

# 🔐 Security Best Practices

- Use a non-root user inside the container.
- Use minimal base images such as Alpine.
- Configure CPU and memory limits.
- Enable health checks.
- Scan Docker images for vulnerabilities.

---

# 📈 Scaling

## Run Multiple Instances

```bash
docker run -d -p 8001:80 --name web-server-1 horizontechx-web-server:1.0
docker run -d -p 8002:80 --name web-server-2 horizontechx-web-server:1.0
docker run -d -p 8003:80 --name web-server-3 horizontechx-web-server:1.0
```

## Load Balancing

Use Nginx as a reverse proxy to distribute traffic across multiple container instances.

---

# 📝 Key Learnings

- Containerization provides isolated and reproducible environments.
- Learned the Docker container lifecycle.
- Implemented health monitoring.
- Configured networking and port mapping.
- Used volumes for persistent storage.
- Applied Docker security and optimization best practices.
