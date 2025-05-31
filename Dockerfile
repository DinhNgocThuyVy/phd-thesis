# Use the official Quarto container from GitHub Container Registry
FROM ghcr.io/quarto-dev/quarto:1.8.11

# Switch to root to install additional packages
USER root

# Install Python packages needed for the thesis
RUN apt-get update && apt-get install -y python3-pip \
    && pip3 install --no-cache-dir \
        pyyaml \
        pandas \
        matplotlib \
        seaborn \
        plotly \
        jupyter \
        notebook \
        numpy \
        scipy \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /workspace

# Create cache directories with proper permissions for both Quarto and Deno
RUN mkdir -p /tmp/quarto-cache /tmp/quarto-project /.cache/deno /.cache/quarto \
    && chmod -R 777 /tmp/quarto-cache /tmp/quarto-project /.cache

# Set environment variables to avoid file system issues
ENV QUARTO_CACHE_DIR=/tmp/quarto-cache
ENV QUARTO_PROJECT_DIR=/tmp/quarto-project
ENV DENO_DIR=/.cache/deno
ENV XDG_CACHE_HOME=/.cache

# Switch back to default user (if exists)
USER 1001

# Default command
CMD ["quarto", "render"]
