# Stage 1: Build the Node.js application
FROM node:14-alpine as builder

WORKDIR /app

# Copy package.json and install dependencies
COPY package.json .
RUN npm install

# Copy the rest of the application and build
COPY . .
RUN npm run build

# Stage 2: Serve the built assets with Nginx
FROM nginx

# Expose port 80 (default HTTP port)
EXPOSE 80

# Copy the built assets from the builder stage to Nginx's HTML directory
COPY --from=builder /app/build /usr/share/nginx/html
