resource "aws_s3_bucket" "s3" {
  bucket = "${var.prefix}-s3-bucket"
}

resource "aws_s3_bucket_versioning" "s3_versioning" {
  bucket = aws_s3_bucket.s3.id

  versioning_configuration {
    status = var.versioning ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_policy" "s3_policy" {
  bucket = aws_s3_bucket.s3.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "AllowFullControlToOwner",
        Action   = "s3:*",
        Effect   = "Allow",
        Resource = "${aws_s3_bucket.s3.arn}/*",
        Principal = "*"
      }
    ]
  })
  depends_on = [aws_s3_bucket_public_access_block.s3_public_access] 
}

# Public Access Block (Optional for public access)
resource "aws_s3_bucket_public_access_block" "s3_public_access" {
  bucket = aws_s3_bucket.s3.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}