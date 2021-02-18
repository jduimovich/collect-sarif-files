
docker build -t jduimovich/collect-sarif-files .

docker build  -f Dockerfile.test -t jduimovich/sarif-test .
docker run jduimovich/sarif-test snyk.sarif merged.sarif