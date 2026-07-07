# Docker Commands Reference

## Docker Compose (Multi-container)

### Start services

```bash
docker compose up -d
```

### View status

```bash
docker compose ps
```

### View logs

```bash
docker compose logs -f
```

### Stop services

```bash
docker compose down
```

---

# Container Management

```bash
docker ps
docker ps -a
docker run [OPTIONS] IMAGE
docker start CONTAINER
docker stop CONTAINER
docker restart CONTAINER
docker rm CONTAINER
```

---

# Monitoring

```bash
docker logs CONTAINER
docker stats CONTAINER
docker inspect CONTAINER
docker top CONTAINER
```

---

# Image Management

```bash
docker build -t IMAGE_NAME .
docker images
docker push IMAGE_NAME
docker pull IMAGE_NAME
docker rmi IMAGE_NAME
```

---

# Monitoring & Health Checks

```bash
docker ps --format "table {{.Names}}\t{{.Status}}"
docker inspect web-server | grep -A 10 "Health"
```
