variable "aws_region" {
  type    = string
  default = "eu-west-1"   # change to desired region
}


variable "availability_zone" {
  type    = string
  default = "eu-central-1a"
}

variable "key_pair_name" {
  description = "Existing AWS key pair name for SSH access"
  type = string
}

variable "ssh_public_key" {
  description = "Optional public key to create key pair if not existing"
  type = string
  default = ""
}

variable "email_alert" {
  description = "Email to receive CPU alerts (SNS subscription)"
  type = string
  default = "50"
}
