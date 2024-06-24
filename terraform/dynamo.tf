module "dynamo" {
  source = "terraform-aws-modules/dynamodb-table/aws"

  name = var.environment

  server_side_encryption_enabled = false
  deletion_protection_enabled    = true

  hash_key    = "this"
  range_key   = "that"
  table_class = "STANDARD"

  ttl_enabled = false

  attributes = [{
    name = "this"
    type = "S"
    }, {
    name = "that"
    type = "S"
    }
  ]

  tags = var.tags
}
