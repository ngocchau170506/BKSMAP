FROM node:20-alpine

WORKDIR /app

# copy package first để cache npm install
COPY package*.json ./

RUN npm install

# copy toàn bộ source
COPY . .

# Prisma generate (chỉ chạy build image)
RUN npx prisma generate

EXPOSE 3000

# mặc định dev (có thể override bằng docker-compose)
CMD ["npm", "run", "dev"]