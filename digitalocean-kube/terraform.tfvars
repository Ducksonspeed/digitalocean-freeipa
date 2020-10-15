# DigitalOcean vars
region = "lon1"
image = "ubuntu-20-04-x64"
keyname = "leaseweb"
domain_name = "kube.alexhayward.me"
username = "root"
credentials = "secrets/credentials.env"
app_name = "dev"
instance_count_w = 1
instance_count_m = 1
instance_master = "s-2vcpu-2gb"
instance_worker = "s-2vcpu-2gb"


## System
usertosetup = "ubuntu"