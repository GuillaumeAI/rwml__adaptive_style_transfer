FROM guillaumeai/server:ast-2103220014


RUN git fetch --all
RUN git checkout -b feat-timelining-21040614 origin/feat-timelining-21040614
COPY serve.sh /tmp
RUN git pull
RUN git branch 
RUN ls -ltr
RUN chmod a+x *sh


#
ENTRYPOINT []
#CMD python server.py
CMD bash serve.sh
