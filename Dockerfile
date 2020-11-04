FROM runwayml/model-runner:cpu-python2.7
COPY . /model
WORKDIR /model
RUN model_runner --build .
ENTRYPOINT []
CMD python server.py
