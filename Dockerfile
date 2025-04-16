FROM python:3.10-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    wget \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Clone the repository
RUN git clone https://github.com/Stable-X/Hi3DGen.git /app

# Install Python dependencies
# Note: Assuming requirements are in requirements.txt
# If not available, you may need to modify this after checking the actual repo
RUN pip install --no-cache-dir -r requirements.txt || echo "No requirements.txt found, skipping"

# Install additional dependencies that might be needed
RUN pip install --no-cache-dir \
    gradio \
    diffusers \
    transformers \
    torch \
    torchvision

# Set environment variables
ENV GRADIO_SERVER_NAME="0.0.0.0"

# Expose port 7860 for Gradio interface
EXPOSE 7860

# Command to run the application
# Note: You may need to adjust this based on the actual entry point in the repository
CMD ["python", "app.py"]
