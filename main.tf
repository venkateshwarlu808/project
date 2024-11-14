provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = file(var.gcp_credentials_file)
}

# Generate a unique suffix for bucket names
resource "random_id" "unique_suffix" {
  byte_length = 8
}

# Access Logs Bucket
resource "google_storage_bucket" "access_logs_bucket" {
  name                        = "${var.access_logs_bucket_name}-${random_id.unique_suffix.hex}"
  location                    = var.location
  force_destroy               = true
  uniform_bucket_level_access = true
}

# Website Bucket for Static Content
resource "google_storage_bucket" "website_bucket" {
  name                        = "${var.website_bucket_name}-${random_id.unique_suffix.hex}"
  location                    = var.location
  force_destroy               = true
  uniform_bucket_level_access = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }

  logging {
    log_bucket        = google_storage_bucket.access_logs_bucket.name
    log_object_prefix = "website-access-logs/"
  }

  depends_on = [google_storage_bucket.access_logs_bucket]
}

# Upload Static Website Files
resource "google_storage_bucket_object" "index_html" {
  name   = "index.html"
  bucket = google_storage_bucket.website_bucket.name
  source = var.index_html_path
}

resource "google_storage_bucket_object" "not_found_html" {
  name   = "404.html"
  bucket = google_storage_bucket.website_bucket.name
  source = var.not_found_html_path
}

resource "google_storage_bucket_object" "additional_files" {
  count  = length(var.additional_files)
  name   = element(var.additional_files, count.index)
  bucket = google_storage_bucket.website_bucket.name
  source = element(var.additional_files_paths, count.index)
}


