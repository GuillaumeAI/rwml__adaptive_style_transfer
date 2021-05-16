FROM guillaumeai/server:ast-base-210420
#FROM guillaumeai/server:dev-rw-picasso-2103180139
#FROM guillaumeai/ast:runwayml_picasso_2103180139

RUN apt update && apt upgrade -y
RUN apt install ccrypt -y

WORKDIR /model
RUN git clone https://github.com/GuillaumeAI/rwml__adaptive_style_transfer.git .


#
ENTRYPOINT []
CMD python compo-server-three-v2-dev.py 
