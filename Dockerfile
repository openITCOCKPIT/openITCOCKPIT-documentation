FROM alpine:3.24

RUN apk update && apk add python3 py3-pip py3-wheel git
RUN apk add python3-dev gcc g++ make automake
RUN pip install --break-system-packages properdocs==1.6.7 && \
pip install --break-system-packages mkdocs-materialx==10.2.1 && \
pip install --break-system-packages markdown-include==0.8.1 && \
pip install --break-system-packages mkdocs-glightbox==0.5.2

# https://properdocs.org/user-guide/installation/
# https://jaywhj.github.io/mkdocs-materialx/installation.html

EXPOSE 8000

CMD ["/usr/bin/properdocs", "serve", "-o"]

