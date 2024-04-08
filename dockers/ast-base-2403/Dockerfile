FROM jgwill/ubuntu:20.04


ARG DEBIAN_FRONTEND=noninteractive

# WORKDIR /__jgwillinstall
# COPY build/jgw_optimize_docker_build.sh .
# RUN bash jgw_optimize_docker_build.sh


RUN \
    --mount=type=cache,target=/var/cache/apt \ 
 	apt update && apt upgrade -y


RUN \
    --mount=type=cache,target=/var/cache/apt \ 
        apt install -y sudo build-essential cmake  libre2-dev 
        #make gcc g++ libopencv-dev

RUN \
    --mount=type=cache,target=/var/cache/apt \ 
        apt install -y make gcc


RUN wget https://repo.anaconda.com/miniconda/Miniconda2-latest-Linux-x86_64.sh && \
     bash Miniconda2-latest-Linux-x86_64.sh  -b -p /miniconda && \
     rm Miniconda2-latest-Linux-x86_64.sh && \
     /miniconda/bin/conda update conda --yes && \
        /miniconda/bin/conda init && \
        echo 'export PATH=/miniconda/bin:$PATH' >> /etc/bash.bashrc

#RUN conda install python=2 --yes


# RUN \
#     --mount=type=cache,target=/var/cache/apt \ 
#         apt install -y \
# 	python2 python2.7-dev  python-pip 

# RUN update-alternatives --install /usr/bin/pip pip /usr/bin/pip2 100




# RUN conda update conda --yes
#RUN /miniconda/bin/conda update conda --yes

#RUN /miniconda/bin/conda init

    # python2-pip
WORKDIR /model




RUN \
    --mount=type=cache,target=/root/.cache \
        /miniconda/bin/pip install -U pip

RUN \
    --mount=type=cache,target=/root/.cache \
        /miniconda/bin/pip install \
        tensorboard==1.15.0 \
        tensorflow==1.15.0

RUN \
    --mount=type=cache,target=/root/.cache \
        /miniconda/bin/pip install \
            tensorflow-estimator==1.15.1
 
RUN \
    --mount=type=cache,target=/root/.cache \
        /miniconda/bin/pip install \
                    absl-py==0.9.0\
                    asn1crypto==0.22.0\
                    astor==0.8.1\
                    backports.weakref==1.0.post1\
                    Brotli==1.0.7\
                    certifi==2019.11.28\
                    cffi==1.10.0\
                    chardet==3.0.4\
                    click==7.1.2\
                    colorcet==2.0.2    


RUN \
--mount=type=cache,target=/root/.cache \
    /miniconda/bin/pip install \
                enum34==1.1.6\
                Flask==1.1.2\
                Flask-Compress==1.5.0\
                Flask-Cors==3.0.8\
                Flask-Sockets==0.2.1\
                funcsigs==1.0.2\
                functools32==3.2.3.post2\
                futures==3.3.0\
                gast==0.2.2\
                gevent==20.6.2\
                gevent-websocket==0.10.1\
                google-pasta==0.2.0\
                greenlet==0.4.16\
                grpcio==1.30.0\
                h5py==2.10.0

                # cryptography==1.8.1\

RUN \
--mount=type=cache,target=/root/.cache \
    /miniconda/bin/pip install \
                    idna==2.6\
                ipaddress==1.0.18\
                itsdangerous==1.1.0\
                Jinja2==2.11.2\
                Keras-Applications==1.0.8\
                Keras-Preprocessing==1.1.2\
                Markdown==3.1.1\
                MarkupSafe==1.1.1\
                mock==3.0.5\
                numpy==1.15.0\
                opt-einsum==2.3.2\
                packaging==16.8\
                param==1.9.3\
                Pillow==6.2.2\
                protobuf==3.12.2\
                pycosat==0.6.3\
                pycparser==2.18\
                pycrypto==2.6.1\
                pyct==0.4.6\
                pyOpenSSL==17.0.0\
                pyparsing==2.2.0\
                PySocks==1.7.1\
                PyYAML==3.11      


RUN \
    --mount=type=cache,target=/root/.cache \
        /miniconda/bin/pip install \
            runway-python==0.5.9 \
            scipy==1.1.0 \
            six==1.15.0


RUN \
    --mount=type=cache,target=/root/.cache \
        /miniconda/bin/pip install tqdm
RUN \
    --mount=type=cache,target=/root/.cache \
        /miniconda/bin/pip install \
                    Unidecode==1.1.1\
                    urllib3==1.25.7\
                    Werkzeug==1.0.1\
                    wget==3.2\
                    wrapt==1.12.1\
                    zope.event==4.4\
                    zope.interface==5.1.0

RUN \
    --mount=type=cache,target=/root/.cache \
        /miniconda/bin/pip install cryptography


RUN \
    --mount=type=cache,target=/var/cache/apt \ 
        apt install -y libsm6

RUN \
    --mount=type=cache,target=/root/.cache \
        /miniconda/bin/pip install opencv-python==4.2.0.32

RUN \
    --mount=type=cache,target=/root/.cache \
        /miniconda/bin/pip install re2



WORKDIR /root/runner
COPY runner .

RUN /miniconda/bin/python setup.py sdist --format=gztar bdist_wheel &&     /miniconda/bin/pip  install ./dist/runway_model_runner-0.1.0-py2-none-any.whl 

# RUN \
#     --mount=type=cache,target=/root/.cache \
#         /miniconda/bin/pip install ./runner/dist/runway_model_runner-0.1.0-py3-none-any.whl



WORKDIR /model

RUN git clone https://github.com/GuillaumeAI/rwml__adaptive_style_transfer.git . && \
    git fetch --all && \
    git checkout v220407-merging-gaia-changes && \
    git pull 
#     && rm -rf .git
    
# RUN rm -rf history evaluation pto_* &>/dev/null
# RUN rm *sh __inst* _tst* *.code-workspace&>/dev/null
# RUN rm d2-* custom-* osiris-*&>/dev/null
# RUN rm -rf x  tests archives&>/dev/null







WORKDIR /model



COPY requirements.txt .



COPY compo-server-doubletwo-v1-dev.py .
COPY compo-server-doubletwo-v2-dev-png.py .
COPY compo-server.py .
COPY compo-server-three.py .
COPY compo-server-three-v2-dev.py .
COPY compo-server-two-v2-dev.py .
COPY compo-singleone-v1-dev-acc.py .
COPY compo-singleone-v1-dev.py .
COPY compo-singleone-v2-dev-acc.py .
COPY convert-to-saved-model.py .

COPY server.py .

# RUN \
#     --mount=type=cache,target=/root/.cache \
#         /miniconda/bin/pip  install -r requirements.txt


# RUN \
#     --mount=type=cache,target=/root/.cache \
#         bash install.sh

RUN echo 'export RW_DEBUG=0;export RW_HOST=0.0.0.0;export RW_PORT=7860' >> /etc/profile
RUN echo export 'RW_MODEL_OPTIONS={"styleCheckpoint":"/data/styleCheckpoint"}' >> /etc/profile


#USER 1000

CMD ["/miniconda/bin/python", "compo-singleone-v2-dev-acc.py"]
