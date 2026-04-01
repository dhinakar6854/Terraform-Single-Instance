resource "null_resource" "prod-file-remoteexec" {

  depends_on = [aws_instance.webserver]

  count = var.environment == "dev" || var.environment == "Dev" ? 1 : 0

  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("Dina-key.pem")
      host        = aws_instance.webserver[count.index].public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod 777 /tmp/script.sh",
      "sudo /tmp/script.sh",
      "sudo apt update -y",
      "sudo apt install -y jq unzip",
      "sudo rm -rf /tmp/terraform",
      "wget https://releases.hashicorp.com/terraform/1.14.6/terraform_1.14.6_linux_amd64.zip -P /tmp",
      "sudo unzip -o /tmp/terraform_1.14.6_linux_amd64.zip -d /tmp",
      "/tmp/terraform version"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("Dina-key.pem")
      host        = aws_instance.webserver[count.index].public_ip
    }
  }
  provisioner "local-exec" {
  command = "echo ${aws_instance.webserver[count.index].public_ip} >> public_ip_details.txt && echo ${aws_instance.webserver[count.index].private_ip} >> private_ip_details.txt"
}
}
