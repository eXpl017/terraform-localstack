resource "aws_dynamodb_table" "mytable" {
  name         = "MyTable"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "DataID"
  table_class  = "STANDARD_INFREQUENT_ACCESS"

  server_side_encryption {
    enabled = true
  }

  attribute {
    name = "DataID"
    type = "S"
  }
}
