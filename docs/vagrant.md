# Valgrant

##  Usefull command

> vagrant up
Start the Vagrantfile inside the current directory

> vagrant ssh *vm name*
Attach shell

> vagrant halt
Shutdown the vms

> vagrant destroy
Destroy every vm

> vagrant destroy *vm name*
Destroy the vm selected

## Activate SSH

```ruby
config.vm.provision "shell", inline: <<-SHELL
    sed -i 's/ChallengeR sponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config
    service ssh restart
SHELL
```
