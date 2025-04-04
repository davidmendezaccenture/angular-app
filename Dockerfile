# Etapa 1: Construir Angular
FROM node:18 AS builder

WORKDIR /app

# Copiar dependencias
COPY angular-app/package*.json ./angular-app/
WORKDIR /app/angular-app
RUN npm install

# Copiar el resto del código Angular y compilar
COPY angular-app/ ./
RUN npm run build

# Etapa 2: Backend con Node.js
FROM node:18

WORKDIR /app

# Copiar backend
COPY package*.json ./
COPY index.js ./
RUN npm install

# Copiar el frontend compilado
COPY --from=builder /app/angular-app/dist/angular-app ./dist/angular-app

EXPOSE 8080

CMD ["node", "index.js"]
