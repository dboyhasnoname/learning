provider "github" {
  token        = "6a256fdb0d256eeda43453ffa6037e04d9260e6b"
  organization = "dboyhasnoname"
}

resource "github_repository" "mukund-tf-repo" {
  name        = "mukund-tf-repo"
  description = "Mukund's new repository for use with Terraform"
}

resource "github_repository" "mukund-tf-repo-ajay" {
  name        = "mukund-tf-repo-ajay"
  description = "AJay's new repository for use with Terraform"
}