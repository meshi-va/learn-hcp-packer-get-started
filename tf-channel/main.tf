provider "hcp" {}

provider "aws" {
  region = var.region
}

data "hcp_packer_iteration" "ubuntu" {
  bucket_name = "learn-packer-ubuntu"
  channel     = "production"
}

data "hcp_packer_image" "ubuntu_us_east_2" {
  bucket_name    = "learn-packer-ubuntu"
  cloud_provider = "aws"
  iteration_id   = data.hcp_packer_iteration.ubuntu.ulid
  region         = "us-east-2"
}

resource "aws_instance" "app_server" {
// If the requested iteration_id is equal to(==) "error_revoked" then(?) the count is 0, else(:), the count is 1
  count         = data.hcp_packer_image.ubuntu_us_east_2.cloud_image_id == "error_revoked" ? 0 : 1
  ami           = data.hcp_packer_image.ubuntu_us_east_2.cloud_image_id
  instance_type = "t2.micro"
  tags = {
    Name = "Learn-HCP-Packer"
  }
}
