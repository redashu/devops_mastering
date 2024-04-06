FROM alpine
RUN apk add python3 
WORKDIR /code
ADD hello.py .  
ENTRYPOINT [ "python3" ]
CMD [ "hello.py" ]