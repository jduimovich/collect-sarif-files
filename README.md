collect-sarif-files

[![CI](https://github.com/jduimovich/collect-sarif-files/actions/workflows/ci.yml/badge.svg)](https://github.com/jduimovich/collect-sarif-files/actions/workflows/ci.yml)

This action is designed to merge multiple sarif files into a single file for upload to Github's code quality scan.  

Github actions github/codeql-action/upload-sarif@v1 only supports a single sarif upload so multiple  scans need to be merged into a single file. 

An example scan output would come from snyk/actions/iac@master which scans single files at a time. 