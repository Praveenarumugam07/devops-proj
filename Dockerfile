FROM python:3.10-slim-bullseye

LABEL maintainer="praveenkrarumugam@gmail.com"
LABEL version="1.0"
LABEL description="Flask app for user management with SQL Server backend"

ENV ACCEPT_EULA=Y
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies and Microsoft ODBC drivers
RUN apt-get update && \
    apt-get install -y curl gnupg2 apt-transport-https software-properties-common && \
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && \
    ACCEPT_EULA=Y apt-get install -y msodbcsql17 unixodbc-dev gcc g++ && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN python -m pip install --upgrade pip && \
    pip install flask mysql-connector-python bcrypt pyodbc

# Test pyodbc installation
RUN python -c "import pyodbc"

# Copy code
COPY . /app
WORKDIR /app

# Run the Flask app
CMD ["python", "app.py"]
