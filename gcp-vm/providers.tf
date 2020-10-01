provider "google" {
  project = "${var.project}"
  region  = "${var.region}"
  credentials = "${file("./secrets/credentials.json")}"
}