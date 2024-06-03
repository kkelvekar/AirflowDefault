# Use the official Airflow image as a parent image
FROM apache/airflow:2.9.1

# Switch to root to install the ODBC driver
USER root

# Install necessary tools for the repository setup and Microsoft ODBC Driver
RUN apt-get update && apt-get install -y gnupg2 curl apt-transport-https \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql17 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Switch back to the default airflow user
USER airflow

# Install the MS SQL provider
RUN pip install apache-airflow-providers-microsoft-mssql
RUN pip install apache-airflow-providers-google