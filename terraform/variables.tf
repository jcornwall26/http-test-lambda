variable suffix {
  type        = string
  description = "suffix to append to resources to make them unique"
}

variable image_uri {
  type        = string
  description = "URI of the Docker image to deploy"
}

variable pagerduty_key {
  type        = string
  description = "key_of_pagerduty"
}