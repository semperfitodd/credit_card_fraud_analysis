resource "aws_kinesis_stream" "this" {
  name = "${var.environment}_stream"

  stream_mode_details {
    stream_mode = "ON_DEMAND"
  }

  tags = var.tags
}