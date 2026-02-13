resource "aws_instance" "this" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.key_name
  subnet_id              = var.subnet_id

  user_data = <<-EOF
    #!/bin/bash
    dnf update -y
    dnf install -y nginx
    systemctl enable nginx
    systemctl start nginx
  EOF

  user_data_replace_on_change = true

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name = var.name
  }
}