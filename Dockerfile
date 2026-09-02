FROM python:3.11-slim

WORKDIR /app

# Actualizar pip y setuptools al inicio para limpiar paquetes vulnerables del sistema
RUN pip install --no-cache-dir --upgrade pip "setuptools>=78.1.1" wheel

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5000

CMD ["python", "sample_app.py"]