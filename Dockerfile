From python:latest
EXPOSE 8888

# Install production dependencies.
RUN pip3 install notebook==6.4.4

# Launch Jupyter
CMD jupyter notebook --ip='*' --allow-root --no-browser --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.base_url='/jupyter'
