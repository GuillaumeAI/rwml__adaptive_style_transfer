#FROM runwayml/model-runner:gpu-python2.7-cuda10.0-runtime
FROM guillaumeai/server:gpu-base-2103251033

WORKDIR /
RUN git clone https://github.com/GuillaumeAI/rwml__adaptive_style_transfer.git /model
WORKDIR /model

# Importing from GuillaumeTF



## Import Prereq we might require in other lib


RUN pip install tensorflow-gpu==1.12.0




RUN apt install git vim -y


## Import Prereq we might require in other lib


RUN pip install tqdm
RUN pip install  numpy  scipy
RUN pip install Pillow

RUN apt-get install libsm6 libxrender1 libfontconfig1 -y


RUN pip install opencv-contrib-python
RUN pip install pandas


##

COPY tsttfversion.sh .


RUN chmod 775 *sh

RUN apt-get clean




RUN pip install --upgrade pip

#RUN pip install runway
RUN pip install runway-python



#
ENTRYPOINT []
CMD python server.py
