# outputs.tf
output "frontend_public_ip" {
  description = "The public IP address of the frontend instance"
  value       = data.aws_instance.frontend.public_ip
}

output "frontend_public_dns" {
  description = "The public DNS of the frontend instance"
  value       = data.aws_instance.frontend.public_dns
}

output "frontend_url_ip" {
  description = "The URL of the frontend instance using public IP"
  value       = "http://${data.aws_instance.frontend.public_ip}:80"
}

output "frontend_url_dns" {
  description = "The URL of the frontend instance using public DNS"
  value       = "http://${data.aws_instance.frontend.public_dns}"
}
