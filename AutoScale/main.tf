resource "aws_launch_configuration" "as_conf" {
  name          = "Linux_config"
  image_id      = "ami-0e11276b"
  instance_type = "t2.micro"
}

resource "aws_autoscaling_group" "auto_scale" {
  availability_zones        = ["us-east-2a","us-east-2b"]
  name                      = "salil-test-asg"
  max_size                  = 5
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = 3
  force_delete              = true

  launch_configuration      = "${aws_launch_configuration.as_conf.name}"

  initial_lifecycle_hook {
    name                 = "testhook"
    default_result       = "CONTINUE"
    heartbeat_timeout    = 60
    lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"


    notification_target_arn = "${var.notification_arn}"
    role_arn                = "${var.notification_role_arn}"
  }

  tag {
    key                 = "Name"
    value               = "Test-asg"
    propagate_at_launch = true
  }

  timeouts {
    delete = "15m"
  }

  tag {
    key                 = "lorem"
    value               = "ipsum"
    propagate_at_launch = false
  }
}
