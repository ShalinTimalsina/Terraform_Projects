resource "aws_key_pair" "my_key" {
  key_name   = "my-ec2-key"
  public_key = file(var.public_key_path)

}