resource "aws_appautoscaling_target" "portfolio_api_ecs_scaling_target" {
  max_capacity       = 4
  min_capacity       = 2
  resource_id        = "service/${aws_ecs_cluster.portfolio_api_cluster.name}/${aws_ecs_service.portfolio_api_ecs_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "portfolio_api_ecs_target_tracking_policy" {
  name               = "portfolio-api-ecs-target-tracking-policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.portfolio_api_ecs_scaling_target.resource_id
  scalable_dimension = aws_appautoscaling_target.portfolio_api_ecs_scaling_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.portfolio_api_ecs_scaling_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    target_value       = 50.0
    scale_out_cooldown = 60
    scale_in_cooldown  = 60
  }
}
