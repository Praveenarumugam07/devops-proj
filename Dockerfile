FROM python:3.10-slim-bullseye

# Set environment variables for non-interactive apt
ENV ACCEPT_EULA=Y
ENV DEBIAN_FRONTEND=noninteractive

# Install prerequisites and MS ODBC driver
RUN apt-get update && \
    apt-get install -y curl gnupg2 apt-transport-https software-properties-common gcc g++ unixodbc-dev msodbcsql17 && \
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && \
    apt-get install -y msodbcsql17 unixodbc-dev gcc g++ && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir flask mysql-connector-python bcrypt pyodbc

# Copy application code
COPY . /app
WORKDIR /app

CMD ["python", "app.py"]
