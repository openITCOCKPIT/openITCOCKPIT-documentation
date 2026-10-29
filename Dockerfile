FROM alpine:3.24

# Known Issues
# Search shows html anchor tags in search results
# Search preview does not render markdown (code blocks are missing)

RUN apk update && apk add python3 py3-pip py3-wheel git
RUN apk add python3-dev gcc g++ make automake
RUN pip install --break-system-packages properdocs==1.6.7 && \
pip install --break-system-packages mkdocs-materialx==10.2.2 && \
pip install --break-system-packages markdown-include==0.8.1 && \
pip install --break-system-packages mkdocs-glightbox==0.5.2 && \
pip install --break-system-packages selectolax==1.0.2

# https://properdocs.org/user-guide/installation/
# https://jaywhj.github.io/mkdocs-materialx/installation.html

EXPOSE 8000

# Remove -f mkdocs.yml as soon as the files have been renamed to properdocs.yml using git mv
CMD ["/usr/bin/properdocs", "serve", "-o", "-f" ,"mkdocs.yml"]

