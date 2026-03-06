FROM alpine:3.18

RUN apk update && apk add python3 py3-pip py3-wheel git
RUN apk add python3-dev gcc g++ make automake
RUN pip install mkdocs==1.6.1 && \
pip install mkdocs-material==9.7.4 && \
pip install markdown-include==0.8.1 && \
pip install mkdocs-glightbox==0.5.2


EXPOSE 8000

# Live reload issue https://github.com/squidfunk/mkdocs-material/issues/8478
CMD ["/usr/bin/mkdocs", "serve", "--livereload"]

