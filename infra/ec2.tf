resource "tls_private_key" "ssh_machine_example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_secretsmanager_secret" "ssh_private_key" {
  name = "ssh-private-key-example"
}

resource "aws_secretsmanager_secret_version" "ssh_private_key_version" {
  secret_id     = aws_secretsmanager_secret.ssh_private_key.id
  secret_string = tls_private_key.ssh_machine_example.private_key_pem
}

resource "aws_key_pair" "generated_key" {
  key_name   = "ssh-key-example"
  public_key = tls_private_key.ssh_machine_example.public_key_openssh
}


resource "aws_instance" "s3_bench" {
  ami           = "ami-0d57c0143330e1fa7" # Dummy AMI ID
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  key_name = "generated_key"
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic from Internet"
 
  ingress {
    description      = "SSH from Internet"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

 egress {
   from_port        = 0
   to_port          = 0
   protocol         = "-1"
   cidr_blocks      = ["0.0.0.0/0"]
   ipv6_cidr_blocks = ["::/0"]
 }

  tags = {
    Name = "allow_ssh"
  }
}

output "instance_ip_addr" {
  value = aws_instance.s3_bench.public_ip
}
