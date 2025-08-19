# Backend Dockerfile

# Use lightweight Node.js image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy dependency files first (better layer caching)
COPY package*.json ./

# Install only production dependencies
RUN npm install --production

# Copy application source
COPY . .

# Create non-root user for security
RUN addgroup -g 1001 -S nodejs \
  && adduser -S express -u 1001 \
  && chown -R express:nodejs /app

# Switch to non-root user
USER express

# Expose application port
EXPOSE 3000

# Start backend
CMD ["node", "index.js"]
