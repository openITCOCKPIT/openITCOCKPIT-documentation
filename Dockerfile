FROM alpine:3.24

RUN apk update && apk add python3 py3-pip py3-wheel git
RUN apk add python3-dev gcc g++ make automake
RUN pip install --break-system-packages mkdocs==1.6.1 && \
pip install --break-system-packages mkdocs-material==9.7.4 && \
pip install --break-system-packages markdown-include==0.8.1 && \
pip install --break-system-packages mkdocs-glightbox==0.5.2 && \
pip install --break-system-packages selectolax==1.0.2

EXPOSE 8000

# Live reload issue https://github.com/squidfunk/mkdocs-material/issues/8478
CMD ["/usr/bin/mkdocs", "serve", "--livereload"]
