output "sg" {
  value = {
    web_sg  = module.sg.security_group_id
  }
}
