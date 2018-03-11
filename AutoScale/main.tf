resource "aws_launch_configuration" "as_conf" {
  name          = "Linux_config"
  image_id      = "ami-0e11276b"
  instance_type = "t2.micro"
}
