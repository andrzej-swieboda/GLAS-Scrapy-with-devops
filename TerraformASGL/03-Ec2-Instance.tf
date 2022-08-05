 
resource "aws_instance" "app_server" {
  ami           = "ami-052efd3df9dad4825"
  instance_type = "t2.micro"

    user_data              = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install
              apt-get install python3 python3-dev python3-pip libxml2-dev libxslt1-dev zlib1g-dev libffi-dev libssl-dev
              pip install scrapy 
              
              EOF

  tags = {
    Name = "Scrapy developer instance"
  }
}