# Use a lightweight Node.js image
FROM node:18-alpine

# Set working directory inside container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json first (for caching layers)
COPY package*.json ./

# Install only production dependencies
RUN npm install --omit=dev

# Copy application source code
COPY . .

# Set environment variable
ENV PORT=3000

# Expose the app port
EXPOSE 3000

# Start the server
CMD ["npm", "start"]
