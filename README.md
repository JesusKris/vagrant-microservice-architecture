<!-- ctrl + shift + v to preview -->
# vagrant-microservice-architecture

## Table of Contents
- [vagrant-microservice-architecture](#vagrant-microservice-architecture)
  - [Table of Contents](#table-of-contents)
  - [General Information](#general-information)
  - [Features](#features)
  - [Technologies Used](#technologies-used)
  - [Team \& My Work](#team--my-work)
  - [Main Learnings](#main-learnings)
  - [Setup](#setup)

## General Information
This project was made as a school project in [kood/Jõhvi](https://kood.tech/) (12.7.2023)

The project required me to create a microservice architecture which included a gateway, a message queue system RabbitMQ & 2 other services with their own PostgreSQL instances. The infrastructure had to be provisioned by Vagrant. The gateway and microservices were all written using Node.js .

![image](./assets/images/crud-master-diagram.png)

  **NB! Different source control platform was used hence no commit history.**

## Features
- Microservice architecture
- Automatic infrastrcture provisioning with Vagrant & VirtualBox
- Message queue system

## Technologies Used

[VirtualBox](https://www.virtualbox.org/)

[Vagrant](https://www.vagrantup.com/)

[Node.js](https://nodejs.org/en)

[PostgreSQL](https://www.postgresql.org/)

[RabbitMQ](https://www.rabbitmq.com/)


## Team & My Work
This was a solo project.

I did everything myself.

## Main Learnings
- Infrastrcture provisioning using Vagrant
- Basic microservice architecture
- API Gateway
- Basics of hypervisors
- Basics of a message queue system
- Basics of PostgreSQL
- Bash scripting

## Setup
Clone the repository
```
git clone https://github.com/JesusKris/vagrant-microservice-architecture.git
```
Install VirtualBox
```
sudo apt install virtualbox
```

Install vagrant
```
sudo apt install vagrant
```

Rename .env-example to .env

Deploy the microservices
```
vagrant up --provider virtualbox
```
