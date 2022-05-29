<<<<<<< HEAD
FROM guillaumeai/server:ast-base-210420
#guillaumeai/server:ast-210406-base
#FROM guillaumeai/server:dev-rw-picasso-2103180139
#FROM guillaumeai/ast:runwayml_picasso_2103180139

=======
FROM guillaumeai/server:ast-210502-compo-three-v2-dev-base

#FROM guillaumeai/server:ast-base-210420
#FROM guillaumeai/server:dev-rw-picasso-2103180139
#FROM guillaumeai/ast:runwayml_picasso_2103180139

# RUN apt update && apt upgrade -y
# RUN apt install ccrypt -y
>>>>>>> bf4311d5df4d13eac3afb16497d3bcac28896037

WORKDIR /model
RUN git clone https://github.com/GuillaumeAI/rwml__adaptive_style_transfer.git .


#
ENTRYPOINT []
CMD python compo-server-three-v2-dev.py 
