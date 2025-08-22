FROM node:18-alpine
WORKDIR /usr/src/app

# Copy dependencies list
COPY package*.json ./

# Install only production dependencies
RUN npm install --omit=dev

# Copy app source code
COPY . .

# Set environment variables
ENV PORT=3000
EXPOSE 3000

# Start app
CMD ["npm", "start"]
