provider "aws" {
  region = "ap-southeast-2" # Replace with your AWS region
}

# Data block to get information about the existing frontend instance
data "aws_instance" "frontend" {
  instance_id = "i-0d5900b1d8a43f0b5" # Replace with your frontend instance ID
}

# Data block to get information about the existing backend instance
data "aws_instance" "backend" {
  instance_id = "i-03f1dbfe0f1b0129e" # Replace with your backend instance ID
}

resource "null_resource" "frontend" {
  provisioner "file" {
    source      = "frontend.sh"
    destination = "/tmp/frontend.sh"

    connection {
      type        = "ssh"
      user        = "ubuntu" # Replace with your SSH user
      private_key = file("/home/jashmeet/terraform-provisioners/ssh-keys1.pem") # Correct the path to your private key
      host        = data.aws_instance.frontend.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/frontend.sh",
      "/tmp/frontend.sh"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu" # Replace with your SSH user
      private_key = file("/home/jashmeet/terraform-provisioners/ssh-keys1.pem") # Correct the path to your private key
      host        = data.aws_instance.frontend.public_ip
    }
  }
}

resource "null_resource" "backend" {
  provisioner "file" {
    source      = "backend.sh"
    destination = "/tmp/backend.sh"

    connection {
      type        = "ssh"
      user        = "ubuntu" # Replace with your SSH user
      private_key = file("/home/jashmeet/terraform-provisioners/ssh-keys1.pem") # Correct the path to your private key
      host        = data.aws_instance.backend.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/backend.sh",
      "/tmp/backend.sh"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu" # Replace with your SSH user
      private_key = file("/home/jashmeet/terraform-provisioners/ssh-keys1.pem") # Correct the path to your private key
      host        = data.aws_instance.backend.public_ip
    }
  }
}
