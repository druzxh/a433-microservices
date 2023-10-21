# Use node 14 version
FROM node:14-alpine

# Set working/root directory on app
WORKDIR /app

# Copy files
COPY . .

# Set production mode
ENV NODE_ENV=production

# Set Database HOST
ENV DB_HOST=item-db

# Install package
RUN npm install --production --unsafe-perm && npm run build

# PORT Expose
EXPOSE 8080

# Running application
CMD ["npm", "start"]
