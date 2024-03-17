# For more information, please refer to https://aka.ms/vscode-docker-python
FROM python:3.12-slim
LABEL org.opencontainers.image.source https://github.com/srajasimman/sample-projects
ENV APP_HOME /app

EXPOSE 5000

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

# Install pip requirements
COPY requirements.txt .
RUN python -m pip install -r requirements.txt

WORKDIR $APP_HOME
COPY . $APP_HOME

# Creates a non-root user with an explicit UID and adds permission to access the $APP_HOME folder
# For more info, please refer to https://aka.ms/vscode-docker-python-configure-containers
RUN adduser -u 5678 --disabled-password --gecos "" appuser && chown -R appuser $APP_HOME

USER appuser

# During debugging, this entry point will be overridden. For more information, please refer to https://aka.ms/vscode-docker-python-debug
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]