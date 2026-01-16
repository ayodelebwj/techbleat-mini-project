resource "aws_launch_template" "public_lt" {
  name_prefix            = "public-lt"
  image_id               = data.aws_ami.web-ami.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.public_asg_sg.id]
  key_name               = var.web_machine_key_name

  iam_instance_profile {
    name = data.aws_iam_instance_profile.web-server-role.name
  }
  tags = {
    Name = "web-instance"
    Role        = "web"
    Environment = "dev"
  }

}

resource "aws_launch_template" "private_lt" {
  name_prefix            = "private-lt"
  image_id               = data.aws_ami.python-ami.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.private_asg_sg.id]
  key_name               = var.python_machine_key_name

  iam_instance_profile {
    name = data.aws_iam_instance_profile.web-server-role.name
  }
  tags = {
    Name = "python-instance"
    Role        = "app"
    Environment = "dev"
  }
}

resource "aws_autoscaling_group" "public_asg" {
  desired_capacity    = 1
  max_size            = 2
  min_size            = 1
  vpc_zone_identifier = [aws_subnet.public_1.id, aws_subnet.public_2.id]

  target_group_arns = [aws_lb_target_group.public_tg.arn]

  launch_template {
    id      = aws_launch_template.public_lt.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_group" "private_asg" {
  desired_capacity    = 1
  max_size            = 2
  min_size            = 1
  vpc_zone_identifier = [aws_subnet.private_1.id, aws_subnet.private_2.id]

  target_group_arns = [aws_lb_target_group.private_tg.arn]

  launch_template {
    id      = aws_launch_template.private_lt.id
    version = "$Latest"
  }
}
