provider "aws" {
    version = "~>1.54"
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "${var.region}"
}

resource "aws_iam_policy" "ccommit_policy" {
    name = "ccommit_policy"
    description = "A test policy"
    policy = "${file("code-commit-role.json")}"

}
resource "aws_iam_role" "ccommit_role" {
    name = "code_commit_role"
    assume_role_policy=<<EOF
{
"Version": "2012-10-17",
"Statement": [
{
    "Action": "sts:AssumeRole",
    "Principal": {
    "Service": "ec2.amazonaws.com"
    },
    "Effect": "Allow"
}
]
}EOF
}


resource "aws_iam_policy_attachment" "test-role-policy-attach"{
    name ="test-role-policy-attach"
    roles= ["${aws_iam_role.ccommit_role.name}"]
    policy_arn ="${aws_iam_policy.ccommit_policy.arn}"
}