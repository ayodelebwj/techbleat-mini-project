# Retrieve PYTHON AMI FROM CUSTOM AMI
data "aws_ami" "python-ami" {

  filter {
    name   = "name"
    values = ["python-ami"]
  }
}

# Retrieve WEB AMI FROM CREATED AMIS
data "aws_ami" "web-ami" {

  filter {
    name   = "name"
    values = ["web-ami"]
  }
}

#Retrieves ubuntu ami from AWS store to provision Jenkins instance
data "aws_ssm_parameter" "ubuntu_2404_ami" {
  name = "/aws/service/canonical/ubuntu/server/24.04/stable/current/amd64/hvm/ebs-gp3/ami-id"
}

#FILTERS UBUNTU AMI ID FROM SSM PARAMETER FOR JENKINS INSTANCE PROVISIONING
data "aws_ami" "ubuntu_2404" {
  owners      = ["099720109477"]
  most_recent = true

  filter {
    name   = "image-id"
    values = [data.aws_ssm_parameter.ubuntu_2404_ami.value]
  }
}

#ACCESS A ROLE FOR WEBSERVER TO ACCESS EC2 RESOURCE
data "aws_iam_instance_profile" "web-server-role" {
  name = "techbleat"
}

