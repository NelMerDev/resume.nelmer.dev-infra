{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PutResumeBucketPolicy",
      "Effect": "Allow",
      "Action": "s3:PutBucketPolicy",
      "Resource": "arn:${partition}:s3:::resume.nelmer.dev"
    }
  ]
}