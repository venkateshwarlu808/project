variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
}

variable "zone" {
  description = "GCP Zone"
  default     = "us-west1a"
}

variable "location" {
  description = "GCP Location (region or multi-region)"
  type        = string
}

variable "website_bucket_name" {
  description = "Name of the website bucket (will have a unique suffix added)"
  type        = string
}

variable "access_logs_bucket_name" {
  description = "Name of the access logs bucket (will have a unique suffix added)"
  type        = string
}

variable "gcp_credentials_file" {
  description = "Path to the GCP service account credentials file"
  type        = string
}

variable "index_html_path" {
  description = "Path to the index.html file"
  type        = string
}

variable "not_found_html_path" {
  description = "Path to the not_found.html file"
  type        = string
}

variable "additional_files" {
  description = "List of additional files to upload to the bucket"
  type        = list(string)
  default     = []
}

variable "additional_files_paths" {
  description = "List of paths to the additional files"
  type        = list(string)
  default     = []
}
