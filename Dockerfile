FROM python:3.9-slim-buster
RUN sudo apt install python3-pip
RUN pip install flask
WORKDIR /app
COPY app.py .
EXPOSE 5000
ENTRYPOINT ["python", "app.py"]