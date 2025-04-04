# Step 1: Build the Angular app
FROM node:18 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the Angular project files
COPY angular-app/ ./

# Build the Angular app
RUN npm run build

# Step 2: Setup Node.js Backend
FROM node:18

# Set the working directory for the backend
WORKDIR /app

# Copy the Node.js application (index.js and package.json)
COPY index.js package.json ./

# Install dependencies for the Node.js backend
RUN npm install

# Copy the built Angular app from the previous stage
COPY --from=build /app/dist/angular-app /app/dist/angular-app

# Expose the port
EXPOSE 8080

# Start the Node.js server
CMD ["node", "index.js"]
