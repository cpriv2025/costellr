
# Instructions
* Execute `generate_files.sh` to create testing files:

  `./generate_files.sh`

* To generate AWS infra: s3 bucket and ec2 instance, execute:

  `cd infra-aws && terraform plan && terraform apply`

* To benchmark performance with different parallelization values, execute:

   `./bench_aws_with_file.sh`

Graph with performance values will be generated in

 https://github.com/cpriv2025/costellr/blob/main/execution_time_graphs.png

# Considerations
To execute benchmark, to minimize cost an small instance _t3.micro_ has been selected. t3 instances are burstable following values apply for network baseline / Burst bandwidth:  0.064 Gbps / 5.0 Gbps. In order to discard impact additional test should be executed with more expensive instances with better network performance, such as c7 instances.

# Questions
Is your solution the fastest possible in terms of cloud infrastructure setup (why?) or do you have ideas on how to improve it further? 

* EC2 networking performance could be improve by selecting and instance with Elastic Network Adapter (ENA) support and fine tunning kernel and networking configurations 

* Setting an ElastiCache for Redis as cache layers can improve latency up to 98%. See: https://aws.amazon.com/blogs/storage/turbocharge-amazon-s3-with-amazon-elasticache-for-redis/

* Using AWS PrivateLink for Amazon S3 for accessing S3 bucket can reduce latency

* Using `aws s3 sync` instead of `aws s3 cp` could also improve performance

