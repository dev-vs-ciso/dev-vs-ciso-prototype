# Use the official Python image from the Docker Hub
FROM python:3.11-slim

# Set the working directory inside the container
WORKDIR /app

# ENV AWS_KEY="AKIAIOSFODNN7EXAMPLE"
# ENV AWS_SECRET="wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"

# Copy the requirements file into the container
COPY requirements.txt .

# Install any Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the current directory contents into the container at /app
COPY . .

# Specify the command to run the application
CMD ["python", "app.py"]
