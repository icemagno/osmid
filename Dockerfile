FROM node:17-bullseye-slim
ENV LANG=pt_BR.utf8 

RUN apt -y update && apt -y upgrade && \
   apt -y install git && \
   mkdir /app
   
RUN cd /app && \
    git clone --depth=1 https://github.com/openstreetmap/iD.git 

WORKDIR /app/iD

COPY ./osm.js /app/iD/modules/services

RUN npm install npm@latest -g
	
RUN npm install phantomjs-prebuilt --ignore-scripts 
	
RUN npm install && npm run all
	
EXPOSE 8080
	
ENTRYPOINT ["npm"]
CMD ["start"]	
	