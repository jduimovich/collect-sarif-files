collect-sarif-files

Github actions github/codeql-action/upload-sarif@v1 only supports a single sarif upload so multiple separate scans need to be merged into a single file. This action is designed to merge multiple sarif files such as the ones produced by snyk/actions/iac@master for each separate scan into a single file.
