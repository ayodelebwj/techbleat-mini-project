# CREATE Python instance
resource "aws_instance" "python_instance" {
  ami                  = data.aws_ami.python-ami.id
  instance_type        = var.python_machine_instance_type
  key_name             = var.python_machine_key_name
  security_groups      = [aws_security_group.private_asg_sg.id]
  subnet_id            = aws_subnet.private_1.id
  iam_instance_profile = data.aws_iam_instance_profile.web-server-role.name


  tags = {
    Role = "backend" //var.python_machine_tag_name
  }
}

# CREATE Web instance
resource "aws_instance" "web_instance" {
  ami                  = data.aws_ami.web-ami.id
  instance_type        = var.web_machine_instance_type
  key_name             = var.web_machine_key_name
  security_groups      = [aws_security_group.public_asg_sg.id]
  iam_instance_profile = data.aws_iam_instance_profile.web-server-role.name
  subnet_id            = aws_subnet.public_1.id

  tags = {
    Role = "frontend" //var.web_machine_tag_name
  }
}

#JENKINS SERVER EC2 RESOURCE BLOCK
resource "aws_instance" "jenkins_instance" {
  ami                  = data.aws_ami.ubuntu_2404.id
  instance_type        = var.jenkins_server_instance_type
  key_name             = var.jenkins_server_key_name
  security_groups      = [aws_security_group.jenkins_sg.id]
  iam_instance_profile = data.aws_iam_instance_profile.web-server-role.name
  subnet_id            = aws_subnet.private_1.id

  user_data = file("./jenkinsimportantbinaries.sh")

  tags = {
    Name = var.jenkins_server_tag_name
  }
}

