FROM python:3.12-slim

WORKDIR /app

# Instala dependencias del sistema (si necesita git o otros para requirements)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copia requirements y instala Python deps
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia el código
COPY . .

# Expone puerto
EXPOSE 8000

# Comando para correr el API
CMD ["uvicorn", "cognee.api.main:app", "--host", "0.0.0.0", "--port", "8000"]
