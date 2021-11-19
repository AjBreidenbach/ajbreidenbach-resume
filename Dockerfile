FROM ubuntu as build
RUN apt-get update --fix-missing && DEBIAN_FRONTEND="noninteractive" apt-get install curl imagemagick coreutils software-properties-common -y
RUN add-apt-repository ppa:xtradeb/apps
RUN curl -sL https://deb.nodesource.com/setup_17.x | bash 
RUN apt-get install nodejs chromium -y
RUN npm i -g pug-cli
RUN chown -R 1000:1000 /root
USER 1000:1000
WORKDIR /root
COPY ./toimg.sh ./resume.pug ./*.svg ./
RUN ./toimg.sh *.svg
RUN pug < resume.pug -p . > resume.html
RUN env CV=true pug -p .< resume.pug  > cv.html
RUN chromium --headless --disable-gpu --no-sandbox --print-to-pdf file:///root/resume.html && mv output.pdf "Andrew Breidenbach Resume.pdf"
RUN chromium --headless --disable-gpu --no-sandbox --print-to-pdf file:///root/cv.html && mv output.pdf "Andrew Breidenbach CV.pdf"
RUN chmod +r *.pdf


FROM nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY *.jpg /usr/share/nginx/html/
COPY --from=build /root/*.html /root/*.pdf /usr/share/nginx/html/
