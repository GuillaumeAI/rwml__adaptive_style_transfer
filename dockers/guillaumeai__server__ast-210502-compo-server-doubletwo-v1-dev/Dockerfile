FROM guillaumeai/server:ast-210502-compo-three-v2-dev-base

#FROM guillaumeai/server:ast-base-210420
#FROM guillaumeai/server:dev-rw-picasso-2103180139
#FROM guillaumeai/ast:runwayml_picasso_2103180139

# RUN apt update && apt upgrade -y
# RUN apt install ccrypt -y
RUN rm -rf /model
WORKDIR /model
RUN git clone https://github.com/GuillaumeAI/rwml__adaptive_style_transfer.git . && rm -rf tests .git

#RUN groupdel -f ubuntu
#RUN userdel --remove  ubuntu

ARG UNAME=jgi
ARG UID=1000
ARG GID=1000
RUN groupadd -g $GID -o $UNAME
RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME
RUN chown -R jgi.jgi /model

USER $UNAME

#
ENTRYPOINT []
CMD python compo-server-doubletwo-v1-dev.py

