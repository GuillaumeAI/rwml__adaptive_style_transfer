#FROM guillaumeai/server:ast-210502-compo-three-v2-dev-base
FROM guillaumeai/server:ast-210606-singleone-v1-dev

ARG UNAME=jgi
ARG UID=1000
ARG GID=1000

USER root
WORKDIR /model


COPY compo-singleone-v1-dev-acc.py .

RUN chown -R jgi.jgi /model

USER $UNAME

ENTRYPOINT []
CMD python compo-singleone-v1-dev-acc.py


