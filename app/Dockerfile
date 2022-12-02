# For more information, please refer to https://aka.ms/vscode-docker-python
FROM python:3.9

RUN sudo apt-get update && sudo apt-get upgrade -y

EXPOSE 8000

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

# Install pip requirements
RUN pip install --upgrade pip
COPY requirements.txt .
RUN python -m pip install -r requirements.txt

WORKDIR /app
COPY . /app

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "app:app"]