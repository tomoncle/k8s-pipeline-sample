FROM docker.io/tomoncleshare/python36:alpine
MAINTAINER tomoncle <1123431949@qq.com>

WORKDIR /workspace
ADD ./ /workspace/jenkins-python

RUN pip install -r /workspace/jenkins-python/requirements.txt

EXPOSE 5000
CMD ["python", "/workspace/jenkins-python/app.py"]
