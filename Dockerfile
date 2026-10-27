FROM python:3.10-slim

# Create a non-root user for Render
RUN useradd -m -u 1000 user
USER user
ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH

WORKDIR $HOME/app

# Copy requirements and install them as the user
COPY --chown=user requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy the notebook
COPY --chown=user . .

# Install the ipykernel as the user
RUN python -m ipykernel install --user --name=python3

# Tell Jupyter to trust the notebook to remove the "not trusted" warning
RUN jupyter trust "Public Opinion.ipynb"

EXPOSE 7860

# Clean startup command
CMD ["voila", "Public Opinion.ipynb", "--port=7860", "--no-browser", "--Voila.ip=0.0.0.0"]
