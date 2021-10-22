From python:latest
EXPOSE 8888 22 443 8080

# Install production dependencies.
RUN pip3 install notebook==6.4.4

# ssh for debugging
RUN mkdir /temp && apt-get update && apt-get install -y git curl wget openssh-server sudo vim
RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 test
RUN echo 'test:test' | chpasswd # sets the password for the user test to test

# web terminal
WORKDIR /temp
RUN wget https://github.com/yudai/gotty/releases/download/v1.0.1/gotty_linux_amd64.tar.gz &&\
    tar -zxvf gotty_linux_amd64.tar.gz
RUN echo "/temp/gotty -w bash > /temp/gotty.out >2&1 &" > gotty.sh && chmod 777 /temp/*

# Launch Jupyter
CMD /etc/init.d/ssh restart && nohup /temp/gotty.sh &&  jupyter notebook --ip='*' --allow-root --no-browser --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.base_url='/jupyter'
