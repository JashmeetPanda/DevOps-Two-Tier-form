provider "aws" {
  region = "ap-southeast-2"  # Replace with your AWS region
}

data "aws_instance" "existing_instance" {
  instance_id = "i-0d5900b1d8a43f0b5"  # Replace with your actual instance ID
}

resource "null_resource" "check_docker" {
  depends_on = [data.aws_instance.existing_instance]

  provisioner "remote-exec" {
    inline = [

      "usermod -aG docker ubuntu",      
      "sudo systemctl restart docker",
      # Check if Docker is installed
      "if command -v docker >/dev/null 2>&1; then echo 'Docker is installed'; else echo 'Docker is not installed'; fi",
      
      # Check if your application is running
      "if sudo docker ps --filter 'ancestor=jashmeet09/frontend' | grep -q 'jashmeet09/frontend'; then echo 'Application is running'; else echo 'Application is not running'; fi"
    ]
    
    connection {
      type        = "ssh"
      user        = "ubuntu"  # Replace with your SSH user if different
      private_key = file("/home/jashmeet/terraform-provisioners/ssh-keys1.pem")  # Replace with the path to your private key
      host        = data.aws_instance.existing_instance.public_ip
    }
  }
}

output "instance_ip" {
  value = data.aws_instance.existing_instance.public_ip
}
