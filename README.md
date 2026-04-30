# Nkrutka Bot — Fly.io Deploy

Telegram **polling** bot. HTTP port ochmaydi — shuning uchun fly.toml'da
`[http_service]` bloki **yo'q** va bo'lmasligi ham kerak.

## 1. Tayyorgarlik

```bash
# Fly CLI o'rnatish
curl -L https://fly.io/install.sh | sh

# Login
flyctl auth login
```

## 2. App yaratish

`fly.toml` ichidagi `app = "kinobotmukamal"` qatorini **o'zingiz xohlagan** unikal nomga o'zgartiring (masalan `app = "mening-botim-1234"`), keyin:

```bash
fly launch --no-deploy --copy-config
```

`fly launch` sizdan "Would you like to copy its configuration..." deb so'rasa — **Yes**.
Postgres, Redis, Sentry kerak emas — barchasiga **No**.

## 3. Volume yaratish (SQLite uchun)

```bash
fly volumes create bot_data --region fra --size 1
```

## 4. Secrets (token va admin ID)

```bash
fly secrets set BOT_TOKEN="123456:ABC..." ADMIN_IDS="8537782289"
```

> Hozirgi `bot.py` ichida default token va admin yozilgan, lekin **secrets**
> orqali berish xavfsizroq.

## 5. Deploy

```bash
fly deploy
```

## 6. Loglarni ko'rish

```bash
fly logs
```

## ❗ "Machine restart count" xatosi bo'lsa

Demak fly.toml'ga `[http_service]` qo'shilgan yoki Fly app HTTP buildpack
bilan yaratilgan. Yechim:

```bash
fly config validate     # konfigni tekshirish
fly deploy --no-cache   # qayta deploy
```

Va fly.toml ichida **HTTP/services bloklari yo'qligiga** ishonch hosil qiling.

## Lokal test

```bash
pip install -r requirements.txt
export BOT_TOKEN="..." ADMIN_IDS="..."
python bot.py
```
