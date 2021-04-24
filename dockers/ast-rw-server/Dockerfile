FROM guillaumeai/server:dev-rw-picasso-2103180139
#FROM guillaumeai/ast:runwayml_picasso_2103180139


# some dev
RUN apt update
RUN apt install vim -y

# Reinstall my repo (not so sure it will work)
WORKDIR /
RUN rm -rf model;mkdir /model 
WORKDIR /model
RUN git clone https://github.com/GuillaumeAI/rwml__adaptive_style_transfer.git .


#
ENTRYPOINT []
CMD python server.py
