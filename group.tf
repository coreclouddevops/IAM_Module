resource "aws_iam_group" "developers" {
  name = "developers"
  path = "/users/"
}


resource "aws_iam_group_policy" "developer_policy" {
  name  = "developer_policy"
  group = aws_iam_group.developers.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_group_membership" "team" {
  name = "developers-group-membership"
  count = length(var.username)
  users = [element(aws_iam_user.newusers.*.name, count.index)]
  group = aws_iam_group.developers.name
}
