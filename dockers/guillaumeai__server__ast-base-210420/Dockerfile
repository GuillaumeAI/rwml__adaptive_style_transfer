FROM guillaumeai/server:dev-rw-picasso-2103180139



# some dev
RUN apt update && apt upgrade -y
RUN apt install ccrypt -y
RUN apt install vim -y

# Reinstall my repo (not so sure it will work)
WORKDIR /
RUN rm -rf model;mkdir /model 

