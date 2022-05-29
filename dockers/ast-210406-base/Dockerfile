FROM guillaumeai/server:ast-2103220014

RUN apt update && apt upgrade -y
RUN apt install ccrypt -y

#RUN pip install opencv-python
WORKDIR /model


RUN git fetch --all
RUN git checkout -b feat-timelining-21040614 origin/feat-timelining-21040614


RUN git pull

