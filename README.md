
# Instructions
* Execute `generate_files.sh` to create testing files:

  `./generate_files.sh`

* To generate infra, s3 bucket and ec2 instance, execute:

  `cd infra && terraform plan && terraform apply`

* To benchmark performance with different parallelization values, execute:

   `./bench_aws_with_file.sh`

Graph with performance values will be generated in

 https://github.com/cpriv2025/costellr/blob/main/execution_time_graphs.png

# TODO  
* Explain results and potencial improvements
* Working version of GCP
* Minor: remove azurite, AWSlocal, move AWS to own folder
* Use HCP as backend
