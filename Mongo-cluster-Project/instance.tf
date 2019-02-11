provider "aws" {
  access_key = "AKIAI3EZ4SRAQTQTUIWQ"
  secret_key = "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"
  region     = "ap-south-1"
}

resource "aws_instance" "Mongo_Master" {
  ami           = "ami-5b673c34"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.mongo-sg.name}"]
  key_name = "pklanka"
  associate_public_ip_address = "true"
  tags {
  Name = "mongo-master"
  }
  provisioner "file"{
      source = "/Users/phanikishorelanka/Desktop/TrainingContent/test.sh"
      destination = "/tmp/test.sh" }
      provisioner "remote-exec" {
                 inline =[ "chmod +x /tmp/test.sh",             
                            "sudo /tmp/test.sh"]
                                }     
                  connection{ type="ssh"
                              user = "ec2-user"
                              private_key = "${file("${var.key-path}")}"
                              }
                              }

resource "aws_instance" "Mongo_Slave" {
  ami           = "ami-0ad42f4f66f6c1cc9"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.mongo-sg.name}"]
  key_name = "pklanka"
  associate_public_ip_address = "true"
  tags {
  Name = "mongo-slave"
  }
  provisioner "file"{
      source = "/Users/phanikishorelanka/Desktop/TrainingContent/test.sh"
      destination = "/tmp/test.sh" }
      provisioner "remote-exec" {
                 inline =[ "chmod +x /tmp/test.sh",             
                            "sudo /tmp/test.sh"]
                                }     
                  connection{ type="ssh"
                              user = "ec2-user"
                              private_key = "${file("${var.key-path}")}"
                              }
                              }

resource "aws_security_group" "mongo-sg" {
    name        = "mongo-sg"
    description = "SSH"
      ingress {    from_port   = 0
                   to_port     = 65535     
                   protocol    = "tcp"
                   cidr_blocks = ["0.0.0.0/0"]
                    }
      egress {
            from_port   = 0    
            to_port     = 0
            protocol    = "-1" 
            cidr_blocks = ["0.0.0.0/0"]
             }
             }