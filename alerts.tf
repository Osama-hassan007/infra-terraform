resource "aws_sns_topic" "cpu_alerts" {
  name = "cpu-alerts-topic"
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.cpu_alerts.arn
  protocol  = "email"
  endpoint  = "youremail@example.com"  # replace with your email
}

resource "aws_cloudwatch_metric_alarm" "frontend_cpu" {
  alarm_name          = "frontend-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 50
  alarm_description   = "Alert if CPU > 50%"
  alarm_actions       = [aws_sns_topic.cpu_alerts.arn]
  dimensions = {
    InstanceId = aws_instance.frontend.id
  }
}

resource "aws_cloudwatch_metric_alarm" "backend_cpu" {
  alarm_name          = "backend-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 50
  alarm_description   = "Alert if CPU > 50%"
  alarm_actions       = [aws_sns_topic.cpu_alerts.arn]
  dimensions = {
    InstanceId = aws_instance.backend.id
  }
}