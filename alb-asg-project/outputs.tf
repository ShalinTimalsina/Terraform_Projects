output "live_alb_dns" {
  description = "This is the dns name of the actual application load balancer"
  value       = "http://${aws_lb.my_alb.dns_name}"


}
