#FROM python:3.8.10
#WORKDIR /code
#RUN apt-get update && \
#    apt-get install -y --no-install-recommends build-essential ffmpeg && \
#    rm -rf /var/lib/apt/lists/*
        
#COPY ./requirements-prod.txt /code/requirements-prod.txt
#RUN python -m pip install --upgrade pip
#RUN pip install --no-cache-dir --upgrade -r /code/requirements-prod.txt
#COPY . /code

#CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]

#---------1 April 2025

FROM python:3.8.10

WORKDIR /code

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential ffmpeg git && \
    rm -rf /var/lib/apt/lists/*


WORKDIR /code

# Copy requirements file and install Python dependencies
COPY ./requirements-prod.txt /code/requirements-prod.txt
RUN python -m pip install --upgrade pip
RUN pip install --no-cache-dir --upgrade -r /code/requirements-prod.txt

# Debugging: Ensure required files exist before copying
RUN ls -lah /code

# Debugging: Verify build context before copying
RUN ls -lah /root/

# Copy the application code
COPY ./main.py /code/
COPY ./query_with_langchain.py /code/
COPY ./io_processing.py /code/
COPY ./logger.py /code/
COPY ./utils /code/
COPY ./telemetry_logger.py /code/
COPY ./telemetry_middleware.py /code/
COPY ./config.ini /code/
#COPY ./config_util.py /code/
COPY ./env_manager.py /code/
COPY ./llm /code/
COPY ./storage /code/
COPY ./translation /code/

# Debugging: Verify files after copying
RUN ls -lah /code

# Start the application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
