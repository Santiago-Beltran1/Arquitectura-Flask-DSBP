FROM python:3.11-alpine

WORKDIR /app

COPY requirements.txt .

# 1. Borramos 'ensurepip' que contiene el setuptools vulnerable de fábrica
# 2. Instalamos pip, wheel y las versiones seguras de forma forzada
# 3. Instalamos los requirements
RUN rm -rf /usr/local/lib/python3.11/ensurepip && \
    pip install --no-cache-dir --upgrade pip "setuptools>=78.1.1" "msgpack>=1.2.1" wheel && \
    pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5000

CMD ["python", "sample_app.py"]