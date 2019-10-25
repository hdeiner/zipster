FROM openjdk:8u222-jre-slim-buster

# make the data folder
#
RUN mkdir /datafolder

# write something to the data file
#
RUN echo "no data here!" > /datafolder/data.txt

# expose the data folder
#
VOLUME /datafolder

CMD tail -f /dev/null