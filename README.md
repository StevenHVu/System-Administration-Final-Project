# Background
For this project, we are tasked with fully automating the provisioning, configurating, and setup of our Minecraft server with using the tools that we learned from class (Ansible, Terraform, Pulumi, Docker, Scripting, GitHub Actions, etc.)

![https://prnt.sc/-EGpLDq87FMt
# Diagram of pipeline procedure
Diagram of the major steps in the pipeline. 

# Prerequisites
- AWS account
- AWS CLI
- Terraform
- Command-line shell (powershell, bash, etc.)

# Install necessary tools
- Install the Terraform CLI: [Install Teraform | Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- Install the AWS CLI: [Installing or updating the latest version of the AWS CLI - AWS Command Line Interface (amazon.com)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

# User configurations
## AWS CLI Credentials & Environment Variables
To use the pipeline, you must configure your AWS CLI credentials. With your AWS account, on the page in which you can start a lab session, click on "AWS details". This will pull up important credentials such as the AWS access key id, secret key, and session token. Copy and paste this information into a file with the path `~/.aws/credentials` (if the folder/file doesn't exist, you'll have to make it!). You might need to configure `minecraft.tf` so that the provider handler has the correct path to these files ```"C:\\Users\\<yourusername>\\.aws\\credentials``` or 

Alternatively, these can be configured by using the `aws configure` command in your shell terminal. For example,
``` aws configure set "<variable>" "<value>"``` (repeat for the each of the three variables)
where you replace the <value> and <variable> for the corresponding AWS CLI information.
  
## AWS Key Pair
In order to connect to the server, you will be needing a key pair. To create a key pair, go to the AWS dashboard, and search for "key pairs" in the search bar. Check to make sure you're in the create region (us-east-1) and click "Create key pair", name the key pair "minecraft", and have its format be `.pem`. 

# Important commands
List of commands to run, with explanations.

# Testing connection to the Minecraft server
How to connect to the Minecraft server once it's running?

# Resources used
- https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html
- https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
- https://github.com/HarryNash/terraform-minecraft
