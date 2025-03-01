variable "share_name" {
  description = "Name of the nfs file share"
  type        = string
}

variable "gateway_arn" {
  type        = string
  description = "Storage Gateway ARN"
}

variable "bucket_arn" {
  type        = string
  description = "Storage Gateway ARN"
}

variable "storage_class" {
  type        = string
  description = "Storage class for NFS file share. Valid options are S3_STANDARD | S3_INTELLIGENT_TIERING | S3_STANDARD_IA | S3_ONEZONE_IA"
  default     = "S3_STANDARD"
  validation {
    condition     = contains(["S3_STANDARD", "S3_INTELLIGENT_TIERING", "S3_STANDARD_IA", "S3_ONEZONE_IA"], var.storage_class)
    error_message = "Incorrect Storage Class. S3_STANDARD | S3_INTELLIGENT_TIERING | S3_STANDARD_IA | S3_ONEZONE_IA"
  }
}

variable "role_arn" {
  type        = string
  description = "The ARN of the AWS Identity and Access Management (IAM) role that a file gateway assumes when it accesses the underlying storage. "
}

variable "client_list" {
  type        = list(any)
  sensitive   = true
  description = "The list of clients that are allowed to access the file gateway. The list must contain either valid IP addresses or valid CIDR blocks. Minimum 1 item. Maximum 100 items."
}

variable "log_group_arn" {
  type        = string
  description = "Cloudwatch Log Group ARN for audit logs"
}

variable "cache_timout" {
  type        = number
  description = "Cache stale timeout for automated cache refresh in seconds. Default is set to 1 hour (3600 seconds) can be changed to as low as 5 minutes (300 seconds)"
  default     = "3600"

  validation {
    condition     = var.cache_timout == 0 || (var.cache_timout >= 300 && var.cache_timout <= 2592000)
    error_message = "Valid Values for Cache Stale Timeout: 0, 300 to 2,592,000 seconds (5 minutes to 30 days)"
  }
}

variable "directory_mode" {
  type        = string
  description = "(Optional) The Unix directory mode in the string form \"nnnn\". Defaults to \"0777\" value"
  default     = "0777"
}

variable "file_mode" {
  type        = string
  description = "(Optional) The Unix file mode in the string form \"nnnn\". Defaults to \"0666\""
  default     = "0666"
}

variable "group_id" {
  type        = number
  description = "(Optional) The default group ID for the file share (unless the files have another group ID specified). Defaults to 65534 (nfsnobody). Valid values: 0 through 4294967294"
  default     = "10100"
  validation {
    condition = (
      var.group_id >= 0 &&
      var.group_id <= 4294967294
    )
    error_message = "Valid values: 0 through 4294967294"
  }
}

variable "owner_id" {
  type        = number
  description = "(Optional) The default owner ID for the file share (unless the files have another owner ID specified). Defaults to 65534 (nfsnobody). Valid values: 0 through 4294967294"
  default     = "10100"
  validation {
    condition = (
      var.owner_id >= 0 &&
      var.owner_id <= 4294967294
    )
    error_message = "Valid values: 0 through 4294967294"
  }
}

variable "tags" {
  type        = map(any)
  description = "(Optional) Key-value map of resource tags."
  default     = {}
}

variable "kms_encrypted" {
  type        = bool
  description = "(Optional) Boolean value if true to use Amazon S3 server side encryption with your own AWS KMS key, or false to use a key managed by Amazon S3. Defaults to false"
  default     = false
}

variable "kms_key_arn" {
  type        = string
  description = "(Optional) Amazon Resource Name (ARN) for KMS key used for Amazon S3 server side encryption. This value can only be set when kms_encrypted is true."
  default     = null
}
