FROM python:3.11-slim
WORKDIR /app

# Copy backend requirements and install dependencies
COPY backend/requirements.txt ./backend/requirements.txt
RUN pip install --no-cache-dir -r backend/requirements.txt

# Copy backend source code and pre-built frontend static files
COPY backend/ ./backend/
COPY dist/ ./dist/

# Set environment variables
ENV PORT=8000
ENV PYTHONUNBUFFERED=1

EXPOSE 8000
WORKDIR /app/backend

CMD uvicorn main:app --host 0.0.0.0 --port ${PORT} --proxy-headers --forwarded-allow-ips="*"
