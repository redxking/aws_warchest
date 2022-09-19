# Define any data sources here

data "aws_ec2_transit_gateway" "stno" {
    id = var.transit_gateway_id[var.region]
}