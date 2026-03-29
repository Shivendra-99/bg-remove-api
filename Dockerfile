FROM node:18

# Install system + python dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    build-essential \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install node deps first (better caching)
COPY package*.json ./
RUN npm install

# Install python deps
COPY requirements.txt ./
RUN pip3 install -r requirements.txt

# Copy rest of app
COPY . .

EXPOSE 3000

CMD ["npm", "start"]
