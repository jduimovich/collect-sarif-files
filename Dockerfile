# Minimal curl tool needed 
FROM alpine:3.10
RUN apk add --update nodejs npm jq 

# Repository script can be run inside and shell or container (with curl)
RUN mkdir /collect-sarif-files 
COPY merge.js /collect-sarif-files/merge.js 
COPY merge-files.sh /collect-sarif-files/merge-files.sh
RUN dos2unix /collect-sarif-files/merge-files.sh
ENTRYPOINT ["/bin/sh", "/collect-sarif-files/merge-files.sh"]