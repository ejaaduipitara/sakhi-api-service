FROM python:3.8.10
WORKDIR /code
RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential ffmpeg && \
    rm -rf /var/lib/apt/lists/*
        
COPY ./requirements-prod.txt /code/requirements-prod.txt
RUN python -m pip install --upgrade pip
RUN pip install --no-cache-dir --upgrade -r /code/requirements-prod.txt
COPY . /code

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]

