variable "zone" {
  description = "Availability zone"
  type        = string
  default     = "ru-central1-d"
}

variable "subnet_id" {
  description = "Subnet ID for VMs"
  type        = string
  default     = "fl8kodkdd9rtagj9sda2"
}

variable "image_id" {
  description = "Ubuntu image ID"
  type        = string
  default     = "fd806c8slu9j1pa87msc"
}
