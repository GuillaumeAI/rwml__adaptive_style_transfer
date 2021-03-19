FROM runwayml/model-runner:cpu-python2.7
COPY . /model
WORKDIR /model
RUN model_runner --build .

# some dev
RUN apt update
RUN apt install vim -y

#
ENTRYPOINT []
CMD python server.py
