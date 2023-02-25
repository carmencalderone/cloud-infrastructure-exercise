# cloud-infrastructure-exercise


This repository contains an example project for the deploy of one AWS VM including installation of WordPress.

## Table of Contents
1. [About this Repo](#About)
2. [Project Details](#AWS)

## About this Repo <a name="About"></a>
This repository is made by Carmen Calderone and it is based on deploy of an infrastructure IaaS using Infrastructure as a Code **Terraform**.

The architecture is based on a single EC2 Virtual Machine deployed on eu-south-1 region (Milan). 

The installation of Wordpress has been done via Linux bash script launched on startup of VM. The web server used for WordPress is Apache 2.0
The code for Wordpress installation was taken from official Ubuntu's documentation. 
https://ubuntu.com/tutorials/install-and-configure-wordpress#7-configure-wordpress

## Infrastructure Details <a name="AWS"></a>

|----------|-------------------------| 

| [**Network**] *Class B VPC based on Milan Region* | \
| [**Operative System**] *Amazon Linux 2* | \
| [**Availability Zone**] *eu-south-1a* | 
