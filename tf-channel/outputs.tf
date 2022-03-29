output "ubuntu_iteration" {
  value = data.hcp_packer_iteration.ubuntu
}

output "ubuntu_us_east_2" {
  value = data.hcp_packer_image.ubuntu_us_east_2
}

output "image_status" {
  value = data.hcp_packer_image.ubuntu_us_east_2.cloud_image_id
}
