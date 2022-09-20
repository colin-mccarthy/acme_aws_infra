output "sg" {
  value = {
    web_sg  = module.web_sg.security_group_id
  }
}
