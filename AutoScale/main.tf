resource "aws_autoscaling_notification" "notifications" {
  group_names = [
    "${aws_autoscaling_group.auto_scale.name}"
  ]

  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
  ]

  topic_arn = "${var.basic_notification_arn}"
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

  launch_configuration      = "Linux_config"
  wait_for_capacity_timeout = 0

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

resource "aws_autoscaling_lifecycle_hook" "testhook" {
  name                   = "testhook"
  autoscaling_group_name = "${aws_autoscaling_group.auto_scale.name}"
  default_result         = "CONTINUE"
  heartbeat_timeout      = 60
  lifecycle_transition   = "autoscaling:EC2_INSTANCE_LAUNCHING"

  notification_target_arn = "${var.notification_arn}"
  role_arn                = "${var.notification_role_arn}"
}
