variable "example_string" {
  type        = string
  description = "An example string variable"
  default     = "Hello, World!"
}

variable "example_number" {
  type        = number
  description = "An example number variable"
  default     = 42
}

variable "example_bool" {
  type        = bool
  description = "An example boolean variable"
  default     = true
}

variable "example_list" {
  type        = list(string)
  description = "An example list variable"
  default     = ["apple", "banana", "cherry"]
}

variable "example_map" {
  type        = map(string)
  description = "An example map variable"
  default = {
    key1 = "value1"
    key2 = "value2"
  }
}



