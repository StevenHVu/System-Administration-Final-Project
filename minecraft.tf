terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
  shared_credentials_files = ["C:\\Users\\vuhoa\\.aws\\credentials"]
  shared_config_files = ["C:\\Users\\vuhoa\\.aws\\config"]
  profile = "default"
}

resource "aws_security_group" "minecraft_server_security_group" {
  name        = "minecraft_server_security_group"
  description = "security group for Minecraft server"

  ingress {
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "minecraft_security_group"
  }
}

resource "aws_instance" "minecraft_server" {
  ami                    = "ami-022e1a32d3f742bd8"  # Specify the appropriate Amazon Machine Image (AMI) ID
  instance_type          = "t2.small"                                              # Specify the desired EC2 instance type
  key_name               = "minecraft"                                             # Specify the name of your EC2 key pair
  vpc_security_group_ids = [aws_security_group.minecraft_server_security_group.id] # Specify the security group ID(s) for the instance

  tags = {
    Name = "MinecraftServer"
  }

  user_data = <<-EOF
              #!/bin/bash
              echo update default packages
              sudo yum -y update

              echo installing 
              sudo rpm --import https://yum.corretto.aws/corretto.key
              sudo curl -L -o /etc/yum.repos.d/corretto.repo https://yum.corretto.aws/corretto.repo
              sudo yum install -y java-17-amazon-corretto-devel.x86_64

              sudo echo "eula=true" > eula.txt
              
              echo "Downloading Minecraft server JAR..."
              wget -O server.jar https://piston-data.mojang.com/v1/objects/84194a2f286ef7c14ed7ce0090dba59902951553/server.jar
              
              echo "Starting Minecraft server..."
              java -Xmx2G -Xms1G -jar server.jar nogui

              sudo tee /etc/systemd/system/minecraft.service << EOT
              
              [Unit]
              Description=mc_server
              After=network.target

              [Service]
              User=ec2-user
              ExecStart=/usr/bin/java -Xmx1024M -Xms1024M -jar /home/ec2-user/server.jar nogui
              ExecStop=stop
              WorkingDirectory=/home/ec2-user
              Restart=always

              [Install]
              WantedBy=multi-user.target
              EOT

              sudo systemctl enable minecraft-service
              sudo systemctl start minecraft-service
              sudo systemctl update minecraft-service
              EOF
}

output "server_ip" {
  value       = aws_instance.minecraft_server.public_ip
  description = "minecraft server instance public address"
}