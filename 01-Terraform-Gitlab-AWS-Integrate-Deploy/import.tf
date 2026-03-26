import {
  to      = module.network.aws_vpc.amvpc
  id      = "vpc-0a7dc8eb09f52cc13"
}

import {
  to      = module.network.aws_subnet.amsubnet
  id      = "subnet-07aeeb5d0be46e10a"
}

import {
  to      = module.network.aws_security_group.amsg
  id      = "sg-0d096b2b1ba49eaae"
}

import {
  to      = module.ec2-windows.aws_instance.am-win-ec2instance[0]
  id      = "i-0e5fbfdbde368de1d"
}

import {
  to      = module.ec2-windows.aws_instance.am-win-ec2instance[1]
  id      = "i-01518dc8f64d6715c"
}
