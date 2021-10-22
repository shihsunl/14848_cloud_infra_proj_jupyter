From python:latest
EXPOSE 8888 22 443

# Install production dependencies.
RUN pip3 install notebook==6.4.4

# ssh
RUN mkdir /temp && apt-get update && apt-get install -y git curl wget openssh-server sudo vim
RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 test
RUN echo 'test:test' | chpasswd # sets the password for the user test to test

# Launch Jupyter
CMD /etc/init.d/ssh restart && jupyter notebook --ip='*' --allow-root --no-browser --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.base_url='/jupyter'
