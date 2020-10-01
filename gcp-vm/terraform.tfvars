# GCP Settings
project = "domaindns-282114"
region = "europe-west2"



# GCP Netwok
public_subnet_cidr_1  = "10.10.1.0/24"

# GCP Instance
instance = "e2-medium"
image = "ubuntu-2004-focal-v20200907"
zone = "europe-west2-a"

# application def
app_name = "kube-test"
app_env = "test"
app_domain = "dev.alexhayward.me"
app_project = "test"

instance_count = "1"

# User


# Files

private_key_path = "~/.ssh/leaseweb"
script_path = "scripts/ans-install.sh"
username = "ubuntu"