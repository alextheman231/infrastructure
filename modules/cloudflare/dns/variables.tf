variable "name" {
  description = "DNS record name (or @ for the zone apex) in Punycode."
  type        = string
}

variable "ttl" {
  description = "Time to live of the DNS record in seconds."
  default     = 1
  type        = number

  validation {
    condition     = !var.proxied || var.ttl == 1
    error_message = "When proxied is true, ttl must be 1 (Auto)."
  }
}

variable "type" {
  description = "Record type. Available values: \"A\", \"AAAA\", \"CNAME\", \"MX\", \"NS\", \"OPENPGPKEY\", \"PTR\", \"TXT\", \"CAA\", \"CERT\", \"DNSKEY\", \"DS\", \"HTTPS\", \"LOC\", \"NAPTR\", \"SMIMEA\", \"SRV\", \"SSHFP\", \"SVCB\", \"TLSA\", \"URI\"."
  type        = string
}

variable "zone_id" {
  description = "The Cloudflare Zone ID"
  type        = string
}

variable "content" {
  description = "A valid IPv4 address"
  type        = string
  default     = null
}

variable "proxied" {
  description = "Whether the record is receiving the performance and security benefits of Cloudflare."
  type        = bool
  default     = true
}
