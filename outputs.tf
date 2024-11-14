output "website_bucket_name" {
  description = "The name of the website bucket"
  value       = google_storage_bucket.website_bucket.name
}

output "access_logs_bucket_name" {
  description = "The name of the access logs bucket"
  value       = google_storage_bucket.access_logs_bucket.name
}
