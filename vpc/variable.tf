variable  "cidr" {
    type = string
    default = "10.0.0.0/16"
}


variable  "public_subnet" {
    type = string
    default = "10.0.1.0/24"
}

variable  "private_subnet" {
    type = string
    default = "10.0.2.0/24"

}


variable  "cidr-block-1" {
    type = string
    default = "0.0.0.0/0"
}

variable  "cidr-block-2" {
    type = string
    default = "0.0.0.0/0"
}


variable  "tags"{
    type = map
    default = {
        Name = "timing"
        Environment = "Dev"
        Terraform = "true"
    }
}