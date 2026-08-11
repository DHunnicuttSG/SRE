Absolutely. For student-led learning, you'll want each module to include clear objectives, directions, screenshots (that you can add later), checkpoints, and reflection questions. Below is a self-guided version that students can complete independently.

AWS Network Fundamentals Lab Guide
Lab Overview

In this lab, you will build a simple AWS network and learn how networking principles apply in cloud environments.

Skills Learned

By completing this lab, you will:

Create an AWS Virtual Private Cloud (VPC)
Configure public and private subnets
Create route tables
Attach an Internet Gateway
Launch EC2 instances
Test connectivity
Explain how traffic flows through a cloud network
Estimated Time

90-120 Minutes

Part 1: Explore Networking Concepts
Step 1: Identify Network Components

Before building your AWS network, answer the following questions:

What is a Network?

Write your answer:

What is an IP Address?

Write your answer:

What is a Router?

Write your answer:

Checkpoint

Discuss with a classmate or instructor:

How does data travel across a network?
What role does an IP address play?
Part 2: Create a Virtual Private Cloud (VPC)
Objective

Create your own private network inside AWS.

Step 1: Log Into AWS
Open the AWS Management Console.
Search for VPC in the search bar.
Select VPC Dashboard.
Step 2: Create the VPC
Click Create VPC.
Select VPC Only.

Enter:

Name: NetworkFundamentalsVPC
IPv4 CIDR: 10.0.0.0/16

Click Create VPC.
Verify

You should now see:

NetworkFundamentalsVPC
10.0.0.0/16

Knowledge Check

Why do we use a VPC instead of placing servers directly on the Internet?

Write your answer:

Part 3: Create a Public Subnet
Objective

Create a subnet that can communicate with the Internet.

Step 1: Open Subnets
Select Subnets from the left menu.
Click Create Subnet.
Step 2: Configure Subnet

Choose:

VPC:
NetworkFundamentalsVPC


Enter:

Subnet Name:
PublicSubnet

Availability Zone:
Choose Any

CIDR Block:
10.0.1.0/24


Click:

Create Subnet

Step 3: Enable Public IP Assignment
Select the subnet.
Choose Actions.
Select Edit Subnet Settings.

Enable:

Auto-assign Public IPv4 Address


Click:

Save

Verify

Your subnet should show:

10.0.1.0/24


with Public IP assignment enabled.

Part 4: Create a Private Subnet
Objective

Create a subnet that is isolated from direct Internet access.

Step 1: Create New Subnet

Click:

Create Subnet


Enter:

Subnet Name:
PrivateSubnet

CIDR:
10.0.2.0/24


Click:

Create Subnet

Verify

You should now have:

PublicSubnet
10.0.1.0/24

PrivateSubnet
10.0.2.0/24

Reflection

Which subnet would be more appropriate for a database server and why?

Part 5: Create an Internet Gateway
Objective

Provide Internet access to the VPC.

Step 1: Navigate to Internet Gateways
Select Internet Gateways.
Click Create Internet Gateway.

Enter:

Name:
NetworkFundamentalsIGW


Click:

Create

Step 2: Attach Gateway
Select the gateway.
Choose Actions → Attach to VPC.
Select:
NetworkFundamentalsVPC

Click Attach.
Verify

Status should display:

Attached

Knowledge Check

What is the purpose of an Internet Gateway?

Part 6: Configure a Route Table
Objective

Allow the public subnet to reach the Internet.

Step 1: Create Route Table

Navigate to:

Route Tables


Select:

Create Route Table


Enter:

Name:
PublicRouteTable

VPC:
NetworkFundamentalsVPC


Click:

Create

Step 2: Add Internet Route

Select the route table.

Choose:

Routes
Edit Routes
Add Route


Enter:

Destination:
0.0.0.0/0

Target:
Internet Gateway


Select:

NetworkFundamentalsIGW


Save changes.

Step 3: Associate Public Subnet

Choose:

Subnet Associations
Edit Associations


Select:

PublicSubnet


Click:

Save Associations

Verify

Your route table should contain:

Destination     Target
0.0.0.0/0       Internet Gateway

Reflection

What would happen if the route table did not contain a route to the Internet Gateway?

Part 7: Launch an EC2 Instance
Objective

Deploy a server into the public subnet.

Step 1: Navigate to EC2

Search for:

EC2


Select:

Launch Instance

Step 2: Configure Instance

Enter:

Name:
WebServer1


Choose:

Amazon Linux 2023


Instance Type:

t2.micro

Step 3: Key Pair

Use:

Existing Key Pair


or create a new one.

Download the key.

Store it securely.

Step 4: Network Settings

Choose:

Network:
NetworkFundamentalsVPC

Subnet:
PublicSubnet

Auto Assign Public IP:
Enable

Step 5: Security Group

Create:

WebServerSG


Allow:

SSH (22)

Source:
My IP


Allow:

HTTP (80)

Source:
Anywhere


Launch instance.

Verify

Wait for:

Instance State:
Running

Part 8: Connect and Test Networking
Objective

Verify Internet connectivity.

Step 1: Connect to Instance

Select:

Instance
Connect
EC2 Instance Connect


Connect to the server.

Step 2: Test DNS Resolution

Run:

ping amazon.com


Expected Result:

Replies received

Step 3: Test Internet Access

Run:

curl https://aws.amazon.com


Expected Result:

HTML output returned

Step 4: View Network Configuration

Run:

ip addr


Record your private IP:

_____________________

Reflection Questions
What IP address range is your instance using?

Answer:

Does the instance have both a public and private IP?

Answer:

Why are both addresses needed?

Answer:

Part 9: Design Challenge
Scenario

A company wants to deploy:

A public website
A private database
Draw the Network
Internet
   |
Internet Gateway
   |
VPC
   |
-----------------
|               |
Public      Private
Subnet      Subnet
|               |
Web Server   Database

Questions
Question 1

Which subnet should host the web server?

Answer:

Question 2

Which subnet should host the database server?

Answer:

Question 3

Should the database receive a public IP address?

Answer:

Question 4

Why would placing a database in a public subnet be risky?

Answer:

Final Challenge

Create a network diagram showing:

VPC
CIDR Blocks
Public Subnet
Private Subnet
Internet Gateway
Route Table
EC2 Instance

Include:

IP ranges used
Expected traffic flow
Public vs Private resources
Security controls used
Cleanup Instructions

To avoid AWS charges:

Delete EC2 Instance
Select the instance.
Click:
Instance State → Terminate

Delete Route Table

Delete:

PublicRouteTable

Delete Subnets

Delete:

PublicSubnet

PrivateSubnet

Detach and Delete Internet Gateway
Detach from VPC.
Delete gateway.
Delete VPC

Delete:

NetworkFundamentalsVPC

Final Verification

Ensure:

No running EC2 instances
No custom VPCs
No Internet Gateways
No custom Route Tables


This turns the lesson into a true hands-on lab workbook that students can complete independently and submit with written answers, screenshots, and network diagrams for assessment.