# Jenkins Security group resource block to allow SSH and TCP port 8080
resource "aws_security_group" "jenkins_sg" {
  name        = var.security_group_name
  vpc_id      = aws_vpc.techbleatvpc.id
  description = "Allow SSH and HTTP"

  ingress {
    description = "SSH"
    from_port   = var.security_group_ingress_ssh_port
    to_port     = var.security_group_ingress_ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.security_group_cidr_block]
  }

  ingress {
    description = "JENKINS PORT"
    from_port   = var.security_group_ingress_jenkins_port
    to_port     = var.security_group_ingress_jenkins_port
    protocol    = "tcp"
    cidr_blocks = [var.security_group_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "public_alb_sg" {
  name   = "public-alb-sg"
  vpc_id = aws_vpc.techbleatvpc.id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.jenkins_sg.id]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "public_asg_sg" {
  name   = "public-asg-sg"
  vpc_id = aws_vpc.techbleatvpc.id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.jenkins_sg.id]
  }


  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.public_alb_sg.id]
  }

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.public_alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "internal_alb_sg" {
  name   = "internal-alb-sg"
  vpc_id = aws_vpc.techbleatvpc.id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.jenkins_sg.id]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.public_asg_sg.id]
  }

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.public_asg_sg.id]
  }

  //ingress {
  //  from_port       = 8000
  //  to_port         = 8000
  //  protocol        = "tcp"
  //  security_groups = [aws_security_group.public_asg_sg.id]
  // }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "private_asg_sg" {
  name   = "private-asg-sg"
  vpc_id = aws_vpc.techbleatvpc.id


  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.jenkins_sg.id]
  }

  //ingress {
  // from_port       = 8080
  // to_port         = 8080
  // protocol        = "tcp"
  // security_groups = [aws_security_group.internal_alb_sg.id]
  //}

  //ingress {
  //  from_port       = 443
  // to_port         = 443
  // protocol        = "tcp"
  // security_groups = [aws_security_group.internal_alb_sg.id]
  //}

  ingress {
    from_port       = 8000
    to_port         = 8000
    protocol        = "tcp"
    security_groups = [aws_security_group.internal_alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security group for RDS
resource "aws_security_group" "postgres_sg" {
  name        = "postgres-sg"
  description = "Allow Postgres traffic"
  vpc_id      = aws_vpc.techbleatvpc.id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.private_asg_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
