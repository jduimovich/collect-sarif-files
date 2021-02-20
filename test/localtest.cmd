
cd ..
docker build  -t jduimovich/collect-sarif-files . 
cd test
docker build  -f Dockerfile.test -t jduimovich/sarif-test .
copy frontend.sarif input.sarif
docker run -v %CD%:/example jduimovich/sarif-test input.sarif merged.sarif
copy fib-go.sarif input.sarif
docker run -v %CD%:/example jduimovich/sarif-test input.sarif merged.sarif