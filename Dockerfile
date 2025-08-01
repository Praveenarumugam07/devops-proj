# Use lightweight Python base image
FROM python:3.10-slim-bullseye

LABEL maintainer="praveenkrarumugam@gmail.com"
LABEL version="1.0"
LABEL description="Flask app for user management with MySQL backend"

# Set environment variable to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && \
    apt-get install -y gcc g++ build-essential libmariadb-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Python packages
COPY requirements.txt .
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Copy application code
COPY . /app
WORKDIR /app

# Run the app
CMD ["python", "app.py"]
