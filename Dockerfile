FROM ubuntu as build
RUN apt-get update --fix-missing && DEBIAN_FRONTEND="noninteractive" apt-get install curl imagemagick coreutils -y
RUN curl -sL https://deb.nodesource.com/setup_17.x | bash 
RUN apt-get install nodejs -y
RUN npm i -g pug-cli
WORKDIR /root
COPY ./toimg.sh ./resume.pug ./*.svg ./
RUN ./toimg.sh *.svg
RUN pug < resume.pug -p . > resume.html
RUN env CV=true pug -p .< resume.pug  > cv.html

FROM nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY *.jpg /usr/share/nginx/html/
COPY --from=build /root/*.html /usr/share/nginx/html/
