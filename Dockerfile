# Start with the official Ubuntu image
FROM ubuntu

# Set the working directory in the container
WORKDIR /app

# Install dependencies (Python, pip, and required tools for creating virtual environments)
RUN apt-get update && \
    apt-get install -y python3 python3-pip python3-venv && \
    apt-get clean

# Copy the requirements.txt and devops directory into the container
COPY requirements.txt /app
COPY devops /app

# Create a virtual environment and install the required Python packages inside it
RUN python3 -m venv /venv && \
    /venv/bin/pip install --upgrade pip && \
    /venv/bin/pip install -r requirements.txt

# Set the PATH to use the virtual environment's Python and pip
ENV PATH="/venv/bin:$PATH"

# Set up the entrypoint and command to run the application
ENTRYPOINT ["python3"]
CMD ["manage.py", "runserver", "0.0.0.0:8000"]
