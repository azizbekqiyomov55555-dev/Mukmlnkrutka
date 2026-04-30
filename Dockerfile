FROM python:3.11-slim

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1 \
    TZ=Asia/Tashkent

WORKDIR /app

# Tizim paketlari
RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
        tzdata \
    && rm -rf /var/lib/apt/lists/*

# Python paketlari
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Loyiha fayllari
COPY . .

# SQLite uchun ma'lumot katalogi (Fly.io volume bilan mount qilinadi)
RUN mkdir -p /data
ENV DB_PATH=/data/smm_bot.db

# Bu polling bot — HTTP port ochmaydi.
CMD ["python", "-u", "bot.py"]
