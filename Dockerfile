FROM node:18-alpine
WORKDIR /usr/src/app

# Copy dependency files first (better caching)
COPY package*.json ./

# Install only production deps using lockfile
RUN npm ci --omit=dev

# Copy the rest of your source code
COPY . .

ENV PORT=3000
EXPOSE 3000

CMD ["node", "server.js"]
