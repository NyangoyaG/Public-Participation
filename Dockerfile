FROM python:3.10-slim

RUN useradd -m -u 1000 user
USER user
ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH

WORKDIR $HOME/app

COPY --chown=user . $HOME/app

RUN pip install --no-cache-dir ipywidgets voila
RUN python -m ipykernel install --user --name=python3

EXPOSE 7860

CMD ["voila", "Public Opinion.ipynb", "--port=7860", "--no-browser", "--Voila.ip=0.0.0.0"]
