FROM python:3.7


RUN mkdir /www
RUN mkdir static
WORKDIR /www
ARG DEPLOYMENT_ENV=production
ENV DJANGO_ENV=${DEPLOYMENT_ENV}
COPY ./docker/src/requirements.txt /www/


ARG SERVER_NAME=local
ENV SERVER_NAME=${SERVER_NAME}
RUN echo "$SERVER_NAME"

# to prevent issue when installing dependency
#RUN pip install --upgrade pip
#RUN pip install --upgrade setuptools
RUN pip install -r requirements.txt
RUN mkdir static

ENV PYTHONUNBUFFERED 1

### install crontab #####
ENV TZ=Asia/Bangkok
RUN apt-get update \
    && apt-get install -y cron \
    && apt-get autoremove -y

ADD ./docker/conf/crontab /etc/cron.d/healtcheck-cron
RUN chmod 0644 /etc/cron.d/healtcheck-cron

#COPY ./docker/conf/crontab /etc/cron.d/crontab
RUN touch /var/log/cron.log

COPY ./docker/src /www/
RUN python --version
RUN cd project
RUN mkdir -p project/static
RUN pwd
RUN ls

RUN echo 'yes' | project/manage.py collectstatic
RUN cp -rf /www/static project/
RUN echo  "argument input ${DEPLOYMENT_ENV}"
RUN echo  "avaliable environment $DJANGO_ENV"

RUN mkdir /www/project/temp

ENV PYTHONWARNINGS="ignore:Unverified HTTPS request"
#ENTRYPOINT [ "gunicorn", "-t", "300", "--workers", "3", "--chdir", "/www/project", "project.wsgi:application", "--bind", "0.0.0.0:8080"  ]
RUN service cron start
RUN /usr/bin/crontab /etc/cron.d/healtcheck-cron
#CMD cron
COPY ./docker/conf/executable.sh /www/
RUN chmod +x /www/executable.sh
CMD /www/executable.sh
