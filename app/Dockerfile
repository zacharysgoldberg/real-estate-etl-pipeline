FROM python:3.9

# RUN apt-get update && apt-get upgrade -y

EXPOSE 8000

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

# Install pip requirements
RUN pip install --upgrade pip
COPY requirements.txt .
RUN python -m pip install -r requirements.txt

# WORKDIR /app
# Copy the entire project into the container
COPY . .

# "--bind", "0.0.0.0:8000",
CMD ["gunicorn", "app:app", "-w", "2", "-b", "0.0.0.0:8000"]
