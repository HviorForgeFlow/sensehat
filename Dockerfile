FROM armhf/ubuntu
MAINTAINER hectorvior@gmail.com

RUN apt-get update && apt-get install -y curl python-numpy python-pil python-pip
WORKDIR /tmp

RUN curl -LO  https://archive.raspberrypi.org/debian/pool/main/r/rtimulib/librtimulib-dev_7.2.1-3_armhf.deb \
 && curl -LO https://archive.raspberrypi.org/debian/pool/main/r/rtimulib//librtimulib-utils_7.2.1-3_armhf.deb \
 && curl -LO https://archive.raspberrypi.org/debian/pool/main/r/rtimulib/librtimulib7_7.2.1-3_armhf.deb \
 && curl -LO https://archive.raspberrypi.org/debian/pool/main/r/rtimulib/python-rtimulib_7.2.1-3_armhf.deb \
 && curl -LO https://archive.raspberrypi.org/debian/pool/main/p/python-sense-hat/python-sense-hat_2.2.0-1_armhf.deb
 
 
RUN dpkg -i librtimulib-dev_7.2.1-3_armhf.deb librtimulib-utils_7.2.1-3_armhf.deb librtimulib7_7.2.1-3_armhf.deb python-rtimulib_7.2.1-3_armhf.deb python-sense-hat_2.2.0-1_armhf.deb

COPY . /usr/src/app

RUN rm -f /tmp/*.deb
RUN apt-get clean

WORKDIR /usr/src/app
#RUN pip install -r requirements.txt


CMD ["python", "test.py"]
#EXPOSE 6899
#CMD ["python","-m","ptvsd","--host","0.0.0.0","--port","6899","--wait","--multiprocess","test.py"]
