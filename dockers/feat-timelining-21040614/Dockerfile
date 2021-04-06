FROM guillaumeai/server:ast-210406-base

RUN pip install opencv-python

RUN git fetch --all
RUN git checkout -b feat-timelining-21040614 origin/feat-timelining-21040614
COPY flag.txt /tmp
RUN git pull
RUN git branch 
RUN ls -ltr
RUN chmod a+x *sh
RUN cat server.py


#
ENTRYPOINT []
#CMD python server.py
CMD bash serve.sh
