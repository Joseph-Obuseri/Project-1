# Project-1

***Automated ELK Stack Deployment***

The files in this repository were used to configure the network depicted below. These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the filebeat-playbook.yml file may be used to install only certain pieces of it, such as the DVWA containers.

•	ansible-config.yml
•	elk-install.yml
•	filebeat-config.yml
•	filebeat-playbook.yml
•	hosts-config.yml
•	metricbeat-config.yml
•	metricbeat-playbook.yml

This document contains the following details:

•	Description of the topology
•	Access Policies
•	ELK Configuration
  -	Beats in Use
  -	Machines Being Monitored
•	How to Use the Ansible Build

**Description of the Topology**

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.
Load balancing ensures that the application will be highly available, in addition to restricting access to the network.
The load balancer helps in the efficient distribution of inbound traffic to the webservers. It also performs health checks on them, thus ensuring the availability of these servers at all times. 
The advantage of a jump box is that it allows for easy administration of multiple assets. It also provides an additional layer between the open internet and the internal webservers, reducing the attack surfaces of our vulnerable VMs.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the event logs and system metrics.

•	Filebeat monitors the log files on your servers by collecting these log events and forwarding them either to Elasticsearch or Logstash for indexing.
•	Metricbeat records metrics from the operating system and from services running on the server.

The configuration details of each machine may be found below.

|    Name     | Function  | IP Address | Operating System |
|-------------|-----------|------------|------------------|
| Jump-Box VM | Gateway   | 10.0.0.6   | Linux            |
| DVWA WEB-1  | Server    | 10.0.0.4   | Linux            |
| DVWA WEB-2  | Server    | 10.0.0.5   | Linux            |
| ELK-Server  | Log Server| 10.1.0.4   | Linux            |


**Access Policies**

The machines on the internal network are not exposed to the public Internet. 
Only the Jump-Box machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses: <my-home-public-ip-address>

Machines within the network can only be accessed by the Jump-Box VM: VNET IP: 10.0.0.6
The Jump-Box can as well access the ELK VM with its IP address: 10.0.0.6


A summary of the access policies in place can be found in the table below.


| Name         | Publicly Accessible | Allowed IP Address            |
|--------------|---------------------|-------------------------------|
| Jump-Box VM  | Yes                 | My personal home IP           |
| DVWA WEB-1   | No                  | 10.0.0.6                      |
| DVWA WEB-2   | No                  | 10.0.0.6                      |
| ELK-Server   | Yes                 | 10.0.0.6, My personal home IP |
| Load Balancer| Yes                 | Open                          |


**Elk Configuration**

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because it allows for the setting up of multiple containers with little effort. It also allows for a quick set up should the virtual network goes down, adding to the redundancy.

The playbook implements the following tasks:

•	Installs docker.io, python3-pip, and install docker module.

    # Use apt module
    - name: Install docker.io
      apt:
        update_cache: yes
        force_apt_get: yes
        name: docker
        state: present

      # Use apt module
    - name: Install python3-pip
      apt:
        force_apt_get: yes
        name: python3-pip
        state: present

      # Use pip module (It will default to pip3)
    - name: Install Docker module
      pip:
        name: docker
        state: present

•	Increases the virtual memory of the VM that will run the elk server.

      # Use command module
    - name: Increase virtual memory
      command: sysctl -w vm.max_map_count=262144

•	Uses sysctl module, downloads and launches a docker elk container.

      # Use sysctl module
    - name: Use more memory
      sysctl:
        name: vm.max_map_count=262144
        value: ‘262144’
        state: present
        reload: yes

      # Use docker_container module
    - name: download and launch a docker elk container
      docker_container:
        name: elk
        image: sebp/elk:761
        state: started
        restart_policy: always

•	Lists ports that elk will run on and enables docker on start up.

        # Please list the ports that ELK runs on
        published_ports:
          -  5601:5601
          -  9200:9200
          -  5044:5044

      # Use systemd module
    - name: Enable service docker on boot
      systemd:
        name: docker
        enabled: yes- _

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![screenshot](https://user-images.githubusercontent.com/84531383/119436747-68188400-bce2-11eb-8c66-3cda62199b30.PNG)


**Target Machines & Beats**

This ELK server is configured to monitor the following machines:

•	WEB-1: 10.0.0.4
    
•	WEB-2: 10.0.0.5

We have installed the following Beats on these machines:

•	Filebeat
    
•	Metricbeat

These Beats allow us to collect the following information from each machine:

•	Filebeat monitors and collects event logs from the vulnerable VMs and then forwards them to Elasticsearch or Logstash for indexing. An example of such are the logs produced from the MySQL database supporting our application.
•	Metricbeat monitors and collects metrics from the system and services running on the servers. An example of such is cpu usage, which can be used to monitor the system health.

**Using the Playbook**

In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:

•	Copy the configuration file to your ansible container.
•	Update the /etc/ansible/hosts file to include the webservers and the ELK server so ansible can discover and connect to them.
•	Run the playbook, and navigate to http://[elk_public_ip_address]:5601/app/kibana to check that the installation worked as expected.

•	Which file is the playbook? filebeat-config.yml 
•	Where do you copy it? src: /etc/ansible/files/filebeat-config.yml dest: /etc/filebeat/filebeat.yml
•	Which file do you update to make Ansible run the playbook on a specific machine? /etc/ansible/hosts/ file.                      
•	How do I specify which machine to install the ELK server on versus which to install Filebeat on? By adding elk and webservers IP addresses and selecting which group you want them to run on.
•	Which URL do you navigate to in order to check that the ELK server is running? http://[elk_public_ip_address]:5601/app/kibana

Command to run to download an ansible playbook:

•	ansible-playbook <name_of_playbook_file>
    
•	ansible-playbook ansible-playbook.yml

Command to run to update the file:
    
•	nano <name_of_playbook_file>
    
•	nano ansible-playbook.yml
