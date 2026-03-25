moved {
  from = aws_instance.app
  to   = aws_instance.app_server
}

moved {
  from = aws_instance.DataServer
  to   = aws_instance.data_server
}

moved {
  from = aws_instance.webServers
  to   = aws_instance.web_server
}