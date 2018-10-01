#misc scripts for putting, getting and managing objects on s3 


tbd - Create and distribute s3 signed urls. create pre-signed url  for s3  so clinicians without access can have access to raw reports. Also presigned url for cloudfront (can do this from cli or does it need ? think cloudfront pres-igned urls needs to be done in code - https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/PrivateCFSignatureCodeAndExamples.html


#tbd - get specific file version


#tbd- encrypt file

#tbd - decrypt file. need to download first ? https://aws.amazon.com/blogs/security/how-to-encrypt-and-decrypt-your-data-with-the-aws-encryption-cli/


#tbd - glacier request



#multi part upload
#initiate multi part upload - returns upload id
#aws s3api create-multipart-upload --bucket multirecv --key testfile 
#need to split file into parts. e.g use linux split
#then upload parts usingupload id
#aws s3api upload-part --bucket multirecv --key testfile --part-number 1 --body testfile.001 --upload-id sDCDOJiTUVGeKAk3Ob7qMynRKqe3ROcavPRwg92eA6JPD4ybIGRxJx9R0VbgkrnOVphZFK59KCYJAO1PXlrBSW7vcH7ANHZwTTf0ovqe6XPYHwsSp7eTRnXB1qjx40Tk --content-md5 Vuoo2L6aAmjr+4sRXUwf0w==



#create pre-signed url - can only create for individual object
#aws s3 presign s3://btdynspcsn/cftemplates/pcsn_cft_foundation.yml --expires-in 7200
#example output - https://btdynspcsn.s3.amazonaws.com/cftemplates/pcsn_cft_foundation.yml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Expires=7200&X-Amz-Credential=AKIAJGAZ3HYEVZSJECVA%2F20180921%2Feu-west-2%2Fs3%2Faws4_request&X-Amz-SignedHeaders=host&X-Amz-Date=20180921T111256Z&X-Amz-Signature=2cdb319b84062b8967e115a93165eac82fbff00ce8b3cba4b832d8c5a2244453



