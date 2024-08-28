resource "aws_instance" "ec2-terraform-heavy" {
    ami = "ami-0e86e20dae9224db8"
    availability_zone = "us-east-1a"
    instance_type = "t2.small"
    tags = {
      Name = "ec2-terraform"
    }
    ebs_block_device {
      device_name = "/dev/sdh"
      volume_size = 40
      volume_type = "gp3"
    }
}
# Modo fora da aws_instance
# resource "aws_ebs_volume" "ebs-heavy" {
#   size = 40
#   availability_zone = "us-east-1a"
# }
# resource "aws_volume_attachment" "attachment" {
#     device_name = "/dev/sdh"
#     volume_id = aws_ebs_volume.ebs-heavy.id
#     instance_id = aws_instance.ec2-terraform-heavy.id
# }