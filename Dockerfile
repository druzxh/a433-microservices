# Menggunakan node versi 14 yang berjalan di sistem operasi Alpine Linux sebagai base image
FROM node:14-alpine as base
# Mengatur direktori kerja di dalam container sebagai /src
WORKDIR /src
# Meng-copy file package.json dan package-lock.json (jika ada) ke direktori /src di dalam container
COPY package*.json ./
# Stage produksi
FROM base as production
# Mengatur environment variable NODE_ENV ke 'production'
ENV NODE_ENV=production
# Menjalankan npm ci untuk instalasi dependensi berdasarkan file package-lock.json
RUN npm ci
# Menyalin semua file dengan ekstensi .js, .env, dan lainnya ke direktori /src di dalam container
COPY ./*.js ./
COPY ./.env ./
# Menjalankan perintah untuk memulai aplikasi ketika container dijalankan
CMD ["node", "index.js"]


# Stage pengembangan
FROM base as dev
# Menambahkan bash dan wait-for-it.sh ke dalam container untuk pengembangan
RUN apk add --no-cache bash
RUN wget -O /bin/wait-for-it.sh https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh
RUN chmod +x /bin/wait-for-it.sh
# Mengatur environment variable NODE_ENV ke 'development'
ENV NODE_ENV=development
# Menjalankan npm install untuk instalasi dependensi berdasarkan file package.json
RUN npm install
# Menyalin semua file dengan ekstensi .js, .env, dan lainnya ke direktori /src di dalam container
COPY ./*.js ./
COPY ./.env ./
# Menjalankan perintah untuk memulai aplikasi ketika container dijalankan
CMD ["node", "index.js"]