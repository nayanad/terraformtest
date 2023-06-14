provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           =  "ami-024fc608af8f886bc" 
  instance_type = "t2.micro"

  tags = {
   Name = "NayanaTerraform"
  }
}
