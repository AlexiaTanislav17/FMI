FROM python:3.10-slim

RUN apt-get update && \
    apt-get install -y curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip install flask

WORKDIR /app

COPY . /app

CMD ["python3", "app.py"]
