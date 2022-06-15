FROM guillaumeai/server:ast-2103220014
#FROM guillaumeai/server:ast-base-210420
#FROM guillaumeai/server:dev-rw-picasso-2103180139
#FROM guillaumeai/ast:runwayml_picasso_2103180139



WORKDIR /model
#RUN git pull

#RUN git clone https://github.com/GuillaumeAI/rwml__adaptive_style_transfer.git .

## Install what is required for trainning
RUN apt update && apt upgrade -y
RUN /miniconda/bin/python -m pip install --upgrade pip
RUN pip install pandas

RUN apt-get install curl -y
WORKDIR /installconda
RUN curl https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh --output condainst.sh
RUN echo yes > yes && echo yes >> yes
#RUN bash condainst.sh <yes

#RUN apt install python-opencv -y
#RUN apt install python-opencv-apps -y


#pip install opencv-python
#RUN pip install opencv-python


WORKDIR /model
RUN git pull

#
ENTRYPOINT []
#CMD python compo-server-three.py 
