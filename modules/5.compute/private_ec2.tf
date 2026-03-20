resource "null_resource" "previous" {}

resource "time_sleep" "wait_60_seconds" {
  depends_on = [null_resource.previous]
  create_duration = "30s"
}

resource "aws_instance" "private-servers" {
  count                       = var.env == "Production" || var.env == "Prod" ? 3 : 1
  ami                         = lookup(var.amis, var.aws_region)
  instance_type               = var.instance_type
  key_name                    = var.key_name
  iam_instance_profile = var.iam_instance_profile
  subnet_id                   = element(var.private_subnets, count.index)
  vpc_security_group_ids      = [var.sg_id]
  associate_public_ip_address = false
  depends_on = [time_sleep.wait_60_seconds, aws_instance.public-servers]
  tags = {
    Name        = "${var.vpc_name}-Private-Server-${count.index + 1}"
    environment = "${var.env}"
    Project = "${local.pname}"
  }
   user_data = <<-EOF
   #!/bin/bash
   apt update -y
   apt install nginx git -y
   cd /home/ubuntu
   git clone https://github.com/dhinakar6854/webhooktesting.git
   rm -f /var/www/html/index.nginx-debian.html
   cp /home/ubuntu/webhooktesting/index.html /var/www/html/index.html
   cp /home/ubuntu/webhooktesting/style.css /var/www/html/style.css
   cp /home/ubuntu/webhooktesting/scorekeeper.js /var/www/html/scorekeeper.js
   chown -R www-data:www-data /var/www/html
   chmod -R 755 /var/www/html
   systemctl restart nginx
   sed -i '29i <center><div id="container"><h1>${var.vpc_name}-Private-Server-${count.index + 1}</h1></div></center>' /var/www/html/index.html
EOF
}
