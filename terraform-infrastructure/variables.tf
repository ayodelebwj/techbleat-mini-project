variable 
# CREATE Java instance
resource "aws_instance" "java_instance" {
  ami             = data.aws_ami.java-ami.id
  instance_type   = "t3.micro"              
  key_name        = "ohio-key"               
  security_groups = [aws_security_group.java_sg.name]

  tags = {
    Name = "java-Instance"
  }
}
