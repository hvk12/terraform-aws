
resource "aws_iam_instance_profile" "test_profile" {
  name = "test_profile"
  role = "${data.aws_iam_role.ccommit_intanceprofile.name}"
}
data "aws_iam_role" "ccommit_intanceprofile" {
  name = "code_commit_role"
}

resource "aws_key_pair" "terraform_ec2_key" {
    key_name = "terraform_ec2_key"
    public_key = "${file("terraform_ec2_key.pub")}"

}
resource "aws_instance" "ccommit_exercise" {
    ami = "${var.ami_image}"
    instance_type = "t2.micro"
    iam_instance_profile = "test_profile"
    key_name = "terraform_ec2_key"
    tags{
        Name ="ccmit_ec2"
    }
    user_data =  "${file("init_ec2.sh")}"

}

/*data "template_file" "user_data" {
    template = "${file("init_ec2.sh")}"

}*/