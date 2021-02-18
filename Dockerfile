# Minimal curl tool needed 
FROM alpine:3.10
RUN apk add --update nodejs npm jq 

# Repository script can be run inside and shell or container (with curl)
COPY merge.js /merge.js 
COPY merge-files.sh /merge-files.sh
RUN dos2unix /merge-files.sh 
ENTRYPOINT ["/bin/sh", "/merge-files.sh"]