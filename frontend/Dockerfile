# Frontend Service Dockerfile
FROM node:18-alpine AS builder

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy application code
COPY . .

# Build React app
RUN npm run build

# Production stage
FROM node:18-alpine

WORKDIR /app

# Install serve to serve the React app
RUN npm install -g serve

# Copy built app from builder
COPY --from=builder /app/build ./build
COPY package*.json ./

# Install production dependencies only
RUN npm install --production

# Expose port
EXPOSE 5000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD wget --quiet --tries=1 --spider http://localhost:5000 || exit 1

# Start application
CMD ["serve", "-s", "build", "-l", "5000"]
