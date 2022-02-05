# Terraform Output Values
/* Concepts Covered
1. For Loop with List
2. For Loop with Map
3. For Loop with Map Advanced
4. Legacy Splat Operator (latest) - Returns List
5. Latest Generalized Splat Operator - Returns the List
*/

# Output - For Loop with List
output "for_output_list" {
  description = "For Loop with List"
  value = [for instance in aws_instance.myec2: instance.public_dns]
}

# Output - For Loop with Map
output "for_output_map1" {
  description = "For Loop with Map"
  value = {for instance in aws_instance.myec2: instance.id => instance.public_dns}
}

# Output - For Loop with Map Advanced
output "for_output_map2" {
  description = "For Loop with Map - Advanced"
  value = {for c, instance in aws_instance.myec2: c => instance.public_dns}
}

# Output Legacy Splat Operator (Legacy) - Returns the List
/*
output "legacy_splat_instance_publicdns" {
  description = "Legacy Splat Operator"
  value = aws_instance.myec2.*.public_dns
}
*/

# Output Latest Generalized Splat Operator - Returns the List
output "latest_splat_instance_publicdns" {
  description = "Generalized latest Splat Operator"
  value = aws_instance.myec2[*].public_dns
}
