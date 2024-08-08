# DevOps-Two-Tier-form

### Problem Statement: Deploying a 2-Tier Application on AWS Cloud Using Terraform and Jenkins

#### Overview
This project involves deploying a 2-tier application on the AWS Cloud using a Jenkins Pipeline with three stages: Create_Infra, Deploy_Apps, and Test_Solution. The process leverages Terraform for infrastructure provisioning, Docker for containerization, and bash scripting for automation. 

#### Stage 1: Create_Infra
1. **Infrastructure Provisioning with Terraform:**
   - **VPC and Subnets:** Create a Public VPC with two subnets: PUBLIC and PRIVATE. Resources in the PUBLIC subnet are accessible through routes, while those in the PRIVATE subnet are restricted.
   - **EC2 Instances:** Launch an instance named FRONTEND in the PUBLIC subnet and another named BACKEND in the PRIVATE subnet.
   - **Communication Test:** Ensure instances can communicate within the VPC, despite the BACKEND being in a private subnet.
   - **Script Provisioning:** Use Terraform provisioners to send `frontend.sh` to the FRONTEND instance and `backend.sh` to the BACKEND instance.

2. **Application Creation and Containerization:**
   - Develop a 2-tier application with a frontend and a backend connected to a database, allowing users to enter details via the frontend and store them in the database.
   - Containerize the application to run the frontend and backend on different systems.
   - Upload the application images to DockerHub and save the pull request commands.

#### Stage 2: Deploy_Apps
1. **Script Execution via Terraform Provisioners:**
   - **frontend.sh:** Installs and configures Docker on the FRONTEND instance and runs the containerized frontend using the pull request command from DockerHub.
   - **backend.sh:** Installs and configures Docker on the BACKEND instance and runs the containerized backend using the pull request command from DockerHub.
   
2. **Validation:**
   - Use the remote-exec provisioner to verify Docker installation and application status on the respective instances.

#### Stage 3: Test_Solution
1. **Output and Display:**
   - Use Terraform outputs to save and display the public DNS or IP address of the FRONTEND instance.
   - Display the exact address and port number for accessing the frontend application.
   
1. **Application Testing:**
   - Use `curl` to check if the frontend containerized application is accessible and functioning via the public DNS or IP.

This project combines infrastructure as code, containerization, and continuous integration/delivery to deploy and test a 2-tier application on AWS efficiently.

#### This repository contains all the files used in this project, along with screenshots and a report.
