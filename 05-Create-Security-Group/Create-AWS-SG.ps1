#######################
# Declare Variables:-
#######################

$Region  = "eu-central-1"
$VpcId   = "vpc-0a7dc8eb09f52cc13"
$SgName  = "app01-sg"
$SgDesc  = "Security group for App01 - RDP HTTP HTTPS and SQL"

$CidrsRdp   = @("192.168.10.10/32","192.168.10.11/32")
$CidrsHttp  = @("192.168.10.11/32","192.168.10.11/32")
$CidrsHttps = @("192.168.20.20/32","192.168.20.25/32")
$CidrsSql   = @("192.168.10.20/32","192.168.10.21/32")


##########################
# Create Security Group:-
##########################

Write-Host "Creating security group..."
$SgId = aws ec2 create-security-group --group-name $SgName --description $SgDesc --vpc-id $VpcId --tag-specifications "ResourceType=security-group,Tags=[{Key=Name,Value=$SgName}]" --region $Region --query GroupId --output text

if (-not $SgId) { throw "Failed to create security group." }

Write-Host "Created SG: $SgId"
Write-Host "Adding ingress rules..."

$CidrsRdp   | ForEach-Object { aws ec2 authorize-security-group-ingress --group-id $SgId --protocol tcp --port 3389       --cidr $_ --region $Region }
$CidrsHttp  | ForEach-Object { aws ec2 authorize-security-group-ingress --group-id $SgId --protocol tcp --port 80         --cidr $_ --region $Region }
$CidrsHttps | ForEach-Object { aws ec2 authorize-security-group-ingress --group-id $SgId --protocol tcp --port 443        --cidr $_ --region $Region }
$CidrsSql   | ForEach-Object { aws ec2 authorize-security-group-ingress --group-id $SgId --protocol tcp --port 1433-1434  --cidr $_ --region $Region }

Write-Host "Done."
Write-Host "SG_ID=$SgId"


