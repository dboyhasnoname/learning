# Ansible

## What is Ansible?

* Ansible is an open-source automation tool, or platform, used for IT tasks such as:
    1. configuration management, 
    2. application deployment, 
    3. provisioning,
    4. orchestration.

* Initial release: February 20, 2012    
* Stable release: 2.7.4 / November 30, 2018
* Original Author: [Michael DeHaan](https://www.linkedin.com/in/michaeldehaan/)

* OS:  Red Hat Enterprise Linux, Debian, CentOS, macOS, BSD, Ubuntu, MacOS, Windows
* Integration: Ansible can deploy to **bare metal hosts**, virtualized systems and cloud environments, including **AWS**, Atomic, CenturyLink, Cloudscale, CloudStack, DigitalOcean, Dimension Data, Docker, Google Cloud Platform, KVM, Linode, LXC, LXD, **Microsoft Azure**, OpenStack, OVH, oVirt, Packet, Profitbricks, PubNub, Rackspace, Scaleway, SmartOS, SoftLayer, Univention, VMware, Webfaction, and XenServer.

* Developers: Ansible Community/ Ansible Inc./ Red Hat Inc.
* Repository: [github.com/ansible/ansible](https://github.com/ansible/ansible)

* Written in: Python, PowerShell, Shell, Ruby
* Requirement: Python 2.7 or higher
* Syntax: YAML

<br>

![ansible basic workflow](img/ansible_workflow_0.jpeg)

<br>

## Why Ansible?

1. **Free:** Ansible is an open-source tool.
2. **Very simple to set up and use:** No special coding skills are necessary to use Ansible’s playbooks.
3. **Powerful:** Ansible lets you model even highly complex IT workflows. 
4. **Flexible:** We can orchestrate the entire application environment no matter where it’s deployed. 
5. **Agentless:** Leaves behind almost nothing. Uses SSH. We don’t need to install any other software or firewall ports on the client systems we want to automate. 
6. **Efficient:** Because we don’t need to install any extra software, there’s more room for application resources on your server.
7. **Secure:** Uses OS level security
8. **Idempotent:** No duplication of effort for configuration.

## Ansible features & capabilities

### Configuration Management
* Ansible is designed to be very simple, reliable and consistent for configuration management.
* Ansible configurations are simple data descriptions of an infrastructure, and are both readable by humans and parsable by machines.(written in yml)

### Application Deployment

* Ansible is the simplest way to deploy our applications. 
* It gives us the power to deploy multi-tier applications reliably and consistently, all from one common framework.
* No need to write custom code to automate our systems; we just list the tasks needed to be done by writing a playbook, and Ansible will figure out how to get our systems to the state we want them to be in.


### Orchestration

* Ansible provides Orchestration in the sense of aligning the business request with the applications, data, and infrastructure. 
* It defines the policies and service levels through automated workflows, provisioning, and change management. 
* This creates an application-aligned infrastructure that can be scaled up or down based on the needs of each application. 

### Provisioning

* Provisioning with Ansible allows us to seamlessly transition into configuration management, orchestration and application deployment using the same simple, human readable, automation language.

![ansible provisoning](img/ansible_provisoning.jpeg)

### Security and Compliance

* As with application deployment, sitewide security policies (such as firewall rules or locking down users) can be implemented along with other automated processes. 
* If we configure the security details on the control machine and run the associated playbook, all the remote hosts will automatically be updated with those details.

## Ansible Architecture

![ansible architecture](img/ansible_architecure.jpg)

1. **Inventory:**
    - The host inventory file determines the target machines where these plays will be executed.
2. **Playbooks:**
    - The playbooks consist of one or more tasks that are expressed either with core modules that come with Ansible or custom modules that you can write for specific situations. 
    - The plays are executed sequentially from top to bottom, so there is no explicit order that you have to define. 
3. **Plugins:**
    - Plugins are pieces of code that augment Ansible’s core functionality.
    - Action, cache and callback plugins are three examples.
4. **Modules:**    
    - Modules are like small programs that Ansible pushes out from a control machine to all the nodes, or remote hosts. 
    - Ansible then executes these modules (over SSH by default), and removes them when finished.
    - Ansible provides more than 450 modules for common tasks.
    - list of moudles: [link](https://docs.ansible.com/ansible/latest/modules/list_of_all_modules.html)
5. **APIs:**
    - Various APIs (application programming interfaces) are available so we can extend Ansible’s connection types (meaning more than just SSH for transport), callbacks and more.
    - Python API: [link](https://docs.ansible.com/ansible/latest/dev_guide/developing_api.html)

## Ansible Structs

1. Controller
2. Playbook
3. Play
4. Facts
5. Inventory
6. Tasks
7. Role
8. Handlers
9. Variables
10. Templates
11. Meta

#### Ansible structs explained:

![ansible structs explaination](img/ansible_struct_explaination.jpeg)

#### Ansible directory structure

![ansible directory structure](img/ansible_dir_structure.jpeg)

## How ansible works?

![ansible flow diagram](img/ansible_workflow.jpeg)

___

* Ansible dependencies: [link](https://github.com/ansible/ansible/blob/a8d4bf86421d151d8df7132e8e87d04b6662f45a/packaging/rpm/ansible.spec)
* Playbook execution code: [link](https://github.com/ansible/ansible/blob/a8d4bf86421d151d8df7132e8e87d04b6662f45a/lib/ansible/executor/playbook_executor.py)
* Playbook libraries: [link](https://github.com/ansible/ansible/tree/a8d4bf86421d151d8df7132e8e87d04b6662f45a/lib/ansible/playbook)
* Inventory libraries: [link](https://github.com/ansible/ansible/tree/a8d4bf86421d151d8df7132e8e87d04b6662f45a/lib/ansible/inventory)
* Ansible modules: [link](https://github.com/ansible/ansible/tree/a8d4bf86421d151d8df7132e8e87d04b6662f45a/lib/ansible/modules)

___


## Ansible ad-hoc commands

* Ad hoc commands are commands which can be run individually to perform quick functions. 
* These ad-hoc commands are not used for configuration management and deployment, because these commands are of one time usage.

#### Syntax

```
ansible <host-group> -m <ansible-moudle> -a <OPT_ARGS> <flags>
```
* flags:
    - `-u {username}`: run command as different user
    - `--ask-pass`, `-k`: prompts for password
    - `-f {n}`: run command in n paralle forks
    - `--become`, `-b`: run command thorugh sudo
    - `--ask-become-pass`, `-K`: interactive prompt to pass password
    - `-i {invenotry file}`
    - `--ask-vault-pass`: to pass vault password in interactive mode  

e.g Copy SSH key manually
```
ansible <HOST_GROUP> -m authorized_key -a "user=root key='ssh-rsa AAAA...XXX == root@hostname'"
```


#### use-cases of [ad-hoc](https://docs.ansible.com/ansible/latest/user_guide/intro_adhoc.html) commands

An ad-hoc command is something that we might type in to do something really quick, but don’t want to save for later.


1. Parallelism and Shell Commands:
    - To run reboot for all servers in a group, `webservers` in inventory, in 12 parallel forks
    ```
    ansible webservers -a "/sbin/reboot" -f 12
    ```
2. File Transfer:
    - Transferring file to many servers/machines
    ```
    ansible webservers -m copy -a "src = /etc/yum.conf dest = /tmp/yum.conf"
    ```
3. Managing Packages:
    - The Ad-hoc commands are available for yum and apt
    ```
    ansible webservers -m yum -a "name = demo-tomcat-1 state = present"
    ```
4. Gathering Facts
    - Facts can be used for implementing conditional statements in playbook.
    ```
    ansible all -m setup 
    ```

_**ansible-adhoc commands should not be used for configuration management and deployment, use playbook instead.**_

## Configuring ansible

* Ansible configuration file uses an INI format to store its configuration data. 
* We can overwrite nearly all of the configuration settings either through Ansible playbook options or environment variables.

* While running an Ansible command, the command looks for its configuration file in a predefined order, as follows:

    ![ansible_cfg_fallback](img/ansible_cfg_fall_back.jpeg)

* Configuration can be done in two ways:
    1. Configuration using environment variables
    2. Configuration using ansible.cfg

### Configuration using environment variables

We can use most of the configuration parameters directly via environment variables by appending ANSIBLE_ to the configuration parameter.

e.g `export ANSIBLE_SUDO_USER=root`

### Configuration using ansible.cfg

Ansible has many configuration parameters. We will consider some of the configuration parameters, as follows, and see how to use them:

Default ansible.cfg:

```
hostfile = /etc/ansible/hosts
library = /usr/share/ansible
forks = 5
sudo_user = root
remote_port = 22
host_key_checking = False
timeout = 60
log_path = /var/log/ansible.log
```


1. `hostfile`: This parameter indicates the path to the inventory file. The inventory file consists of a list of hosts that Ansible can connect to.

2. `library`: Whenever Ansible performs any action, whether it is a local action or a remote one, it uses a piece of code to perform the action; this piece of code is called a **module**. The library parameter points to the path of the directory where Ansible modules are stored. 

3. `forks`: This parameter is the default number of processes that you want Ansible to spawn. It defaults to _five maximum processes in parallel._

4. `sudo_user`: This parameter specifies the default user that should be used against the issued commands.

5. `remote_port`: This parameter is used to specify the port used for SSH connections, which defaults to 22. 

6. `host_key_checking`:  This parameter is used to disable the SSH host key checking; this is set to True by default. 

7. `timeout`: This is the default value for the timeout of SSH connection attempts.

8. `log_path`: By default, Ansible doesn't log anything; if we would like to send the Ansible output to a logfile, then set the value of log_path to the file you would like to store the Ansible logs in.


## Playbooks

* Playbooks are one of the core features of Ansible and tell Ansible what to execute. 
* They are like a to-do list for Ansible that contains a list of tasks; each task internally links to a piece of code called a module. 
* Playbooks are simple human-readable YAML files, whereas modules are a piece of code that can be written in any language with the condition that its _output should be in the JSON format._
* Palybook can be single file or seprated over multiple roles which can perform different set of tasks.

### Play
* A playbook can consist multiple plays.
* Each play conisists of multiple taks.
* Different plays can run on different host groups.
* The function of a play is to map a set of instructions defined against a particular host.

### Directory layout:

![playbook structure](img/directory_layout.jpeg)     

```
mukund@ubuntu:~/all/Ansible$ tree -I "ntc-templates|library"
.
├── group_vars
│   ├── all.yml
├── hosts
├── host_vars
├── roles
│   ├── common
│   │   ├── defaults
│   |   │   ├── main.yml
│   │   ├── files
│   │   ├── handlers
│   |   │   ├── main.yml
│   │   ├── tasks
│   |   │   ├── main.yml
│   │   ├── meta
│   │   ├── templates
│   │   └── vars
│   └── apache
│       ├── defaults
│       ├── files
│       ├── handlers
│       ├── meta
│       ├── tasks
│       │   ├── main.yml
│       ├── templates
│       └── vars
│           ├── main.yml
├── site.retry
├── webservers.yml
├── DBservers.yml
└── master_playbook.yml
```

#### Sample playbook with plays:

```
---
- hosts: terraform 
  pre_tasks:
    - name: Load Environment Variables for Production vCenter
      include_vars:
        file: group_vars/all.yml
  roles:
    - role: vm-setup
    - role: dns-mgmt
      vars:
        dnsip: "{{ output.ansible_facts.hw_eth0.ipaddresses[0] }}" 
      ignore_errors: yes          
  tasks:
     - name: Wait until the DNS name is resolving  
       wait_for: 
         host: "{{ inventory_hostname }}" 
         port: 22 
         state: started 
         timeout: 600 
         delay: 5  
  roles:          
    - role: user-setup        
    - role: app-prerequisites
    - role: app-install
    - role: db-setup
    - role: client-config 

- hosts: localhost
  roles:
    - role: app-config
  post_tasks:
    - name: create Backup job to run at 22.30 daily
      cron:
        job: '/bin/dsmc i /etc/opt/conf /var/opt/conf'
        hour: '22'
        minute: '30'
        state: present
        user: root    

- hosts: localhost
  roles:
    - role: app-repo-creation
```    

### Anatomy of playbook:

* Playbooks can have a list of remote hosts, user variables, tasks, handlers and so on.

![ansible apache play](img/ansible_apache_play.jpg)

1. `hosts`:  This lists the host or host group against which we want to run the task. The hosts field is mandatory and every playbook should have it (except roles).

2. `remote_user`: This is one of the configuration parameters of Ansible  that tells Ansible to use a particular user while logging into the system.

3. `tasks`: All playbooks should contain tasks. Tasks are a list of actions we want to perform. A tasks field contains the name of the task, a module that should be executed, and arguments that are required for the module. 

4. `vars`: Vars tag lets us define the variables which we can use in our playbook. 

#### Directory would look like below:

![apache dir](img/ansibel_apaceh_dir_tree.jpg)

#### Host file:

```
[mukund@ununtu]# cat hosts
host1
```

#### Command to run playbook
`#ansible-playbook -i hosts playbooks/setup_apache.yml`

#### Output: 

![output](img/ansible_apache_output.jpg)

##### Gathering Facts

```
GATHERING FACTS ***************************************************************
ok: [host1]
```

* The aim of this task is to gather useful metadata about the machine in the form of variables; these variables can then be used as a part of tasks that follow in the playbook.

* Gathering facts task obtain information regarding a particular component of the system and do not necessarily change anything on the system

* It is almost equivalent to:
```
ansible -m setup host1 -i hosts
```

* It can be disabled:
```
hosts: host1
gather_facts: False
```

##### PLAY RECAP

* Shows the changed state of system.
* In a large infrastructure, it is highly recommended to monitor or track the number of changed tasks in your infrastructure and alert the concerned tasks if you find oddities; this applies to any configuration management tool in general. 
* In an ideal state, the only time you should see changes is when you're introducing a new change in the form of any Create, Remove, Update, or Delete (CRUD) operation on various system components. 

#### Verbose

`ansible-playbook -i hosts playbooks/setup_apache.yml -vv`

* -v : provides the default output
* -vv:  adds a little more information in JSON format.

![-vv option](img/ansible-vv.jpg)

* -vvv: option adds a lot more information, as shown in the following screenshot. This shows the SSH command Ansible uses to create a temporary file on the remote host and run the script remotely.

![-vvv option](img/ansible-vvv.jpg)


#### listing tasks in playbook

`ansible-playbook -i hosts playbooks/setup_apache.yml --list-tasks`

![list tasks](img/ansible_playbook_list_tasks.jpg)

#### start-at option

It will start executing the task we specify.

![start at task](img/ansible_playbook_start-at.jpg)

## Ansible Variables

* Variables are used to store values that can be later used in playbook. 
* They can be set and overridden in multiple ways. 
* Facts of machines can also be fetched as variables and used. 

* Ansible allows you to set variables in many different ways:
    - by passing a variable file, 
    - declaring it in a playbook, 
    - passing it to the ansible-playbook command using -e / --extra-vars, 
    - by declaring it in an inventory file,
    - prompting in runtime of playbook.

    ```
    - name: Package to install
      pause: prompt="Provide the package name which you want to install "
      register: package_name   
    ```
### The types of variables that Ansible supports are:
1. String, 
2. Numbers, 
3. Float, 
4. List, 
5. Dictionary, 
6. Boolean.      

### Variable names

* All variable names in Ansible should start with a letter. 
* The name can have letters, numbers, and an underscore.

#### VALID VARIABLE NAMES IN ANSIBLE
```
package_name
package_name2
user_input_package
Package
```

#### INVALID VARIABLE NAMES IN ANSIBLE
```
mysql version (multiple words)
mysql.port (a dot)
5 (a number)
user-input (a hyphen)
```

### Ansible variables at different hierarchy levels

1. Variables in an included task file
2. Variables in a playbook
3. Variables in a global file
4. Facts as variables
5. Command-line variables
6. Variables in an inventory file

Precedence of variables:

![variables precedence](img/ansible_vars_precedence.jpeg)


### Variables in an included task file

* Variables in an included task file will override any other variables defined at different levels of hierarchy except the extra variables passed through the command line. 

![ansible variable in task file](img/ansible_var_included_in_task_file.jpg)

First playbook will set a fact for the package name and install Apache depending on the OS distribution; the second one will actually be executed by Ansible, which will first call install_apache.yml and make sure the Apache service is running on the remote host. 
To fetch the package name, we will directly use the package_name variable that was set by the install_apache.yml playbook.

## Variables in a playbook

* Variables in a playbook are set by the vars: key. 
* This key takes a key-value pair, where the key is the variable name and the value is the actual value of the variable. 
* This variable will overwrite other variables that are set by a global variable file or from an inventory file. 

![varibales in playbook](img/ansible_Variables_in_playbook.jpg)

## Variables in a global file

* Variables in Ansible can also be defined in a separate file; this allows us to separate the data (that is, variables) from our playbook. 

![Variables in global file](img/ansible_Variables_in_global_file.jpg)

The preceding example defines some variables where we directly pass a default value, whereas, for AWS_ACCESS_KEY and AWS_SECRET_KEY, we fetch the value from an environment variable using the lookup plugin of the Jinja templating language 

* Variable file precedence:

Ansible will check for a variable in a bottom-to-top manner in-case multiple variable files are present.

![variables files precedence](img/ansible_Variables_in_global_file_1.jpg)

Ansible will first check for a variable named package_name in the var1.yml file. It will stop further lookup if it finds the variable in var3.yml; if not, it will try searching for the variable in var2.yml, and other files if there are any more.


## Facts as variables

```
$ ansible 192.168.33.10 -i inventory -m setup
192.168.33.10 | success >> {
    "ansible_facts": {
        "ansible_all_ipv4_addresses": [
            "10.0.2.15",
            "192.168.33.10"
        ], 
        "ansible_all_ipv6_addresses": [
            "fe80::a00:27ff:fec9:399e",
            "fe80::a00:27ff:fe72:5c55"
        ], 
        "ansible_architecture": "x86_64",
----
        "ansible_distribution_major_version": "6",
        "ansible_distribution_release": "Final",
        "ansible_distribution_version": "6.4",
        "ansible_domain": "localdomain"
----
        "ansible_swapfree_mb": 2559,
        "ansible_swaptotal_mb": 2559,
        "ansible_system": "Linux",
        "ansible_system_vendor": "innotek GmbH",
        "ansible_user_id": "vagrant",
        "ansible_userspace_architecture": "x86_64",
        "ansible_userspace_bits": "64",
```

These facts are now exposed as variables and can be used as part of playbooks by registering them in a ouput variable.

## Command-line variables

* Best to overwrite file/playbook variables.
* We can use the -e or --extra-vars options of the ansible-playbook command by passing a string of key-value pairs, separated by a whitespace.

```
ansible-playbook -i hosts --private-key=~/.ssh/ansible_key playbooks/apache.yml 
--extra-vars "package_name=apache2"
```

* The preceding ansible-playbook command will overwrite the package_name variable if it is mentioned in any of the variable files. 
* **Command-line variables will not override the variables that are set by the set_fact module.** To prevent this type of overriding, we can use Ansible's conditional statements, which will override a variable only if it is not defined. 

## Variables in an inventory file

* We might sometimes need to use a specific list of variables for a specific host. Ansible supports this by declaring your variables inside an inventory file. 

```

[apache]
dev-test-lx01.xyz.com cpu=4 memory=4096 node=master
dev-test-lx02.xyz.com cpu=4 memory=4096 node=slave
```























            














