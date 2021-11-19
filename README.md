# ajbreidenbach-resume
This is a repository for developing and hosting an HTML version of my resume.

It can be viewed locally by running the docker build image 
```
docker build . -t ajbreidenbach-resume:latest && docker run --rm -p 8080:80 ajbreidenbach-resume:latest
```
Navigate to `localhost:8080/resume` or `localhost:8080/cv`, whichever you prefer.
