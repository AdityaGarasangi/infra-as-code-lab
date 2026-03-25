check "verify_instance" {
  assert {
    condition     = aws_instance.app.instance_state == "running"
    error_message = "Instance must be in running state."
  }
}