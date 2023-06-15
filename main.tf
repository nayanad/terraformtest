provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           =  "ami-024fc608af8f886bc" 
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  user_data_replace_on_change = true

  tags = {
   Name = "NayanaTerraform"
  }
}

resource "aws_security_group" "instance" {
  name = "SGTest"
  dynamic "ingress" {
    for_each = toset(local.ports_in)
    content{
      description = "Http add"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  
}
