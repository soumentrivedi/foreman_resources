# foreman_resources #

This module manages resource creation using puppet defined types in foreman

### Pre-requisites:
Puppet master should be setup to conform to Puppet Future Parser requriements as mentioned in
https://docs.puppetlabs.com/puppet/3/reference/experiments_future.html#enabling-the-future-parser

### Parameters: 

 resource_name - any valid defined type in puppet that is available in the puppet module path
 parameters - Parameter hash that needs to be passed into the relevant resource during creation
 default_values - [OPTIONAL] default values for the parameters to be passed during resource creation

### Actions: ###

 create_resource - using puppet 'create_resource' function to create valid puppet resources

### Sample Usage: Creating a Postgresql hba rule (through puppet manifest) ###
```
 $postgresql_hba_hash = {
    'allow access from 10.1.172.12'  => {
      description => "allow access from 10.1.172.12", 
      type => 'host', 
      database => 'all', 
      user => 'all', 
      address => '10.1.172.12/32', 
      auth_method => 'md5', 
      order => '002',
    }
    ,
 }

 $postgresql_db_hash = {
   'mydatabasename' =>   {
      user => 'mydatabaseuser', 
      password => postgresql_password('mydatabaseuser', 'mypassword'),
    }
  , 
 }

 $resources_hash = {
   'postgresql::server::pg_hba_rule' => $postgresql_hba_hash,
   'postgresql::server::db' => $postgresql_db_hash,
 }

 class { 'foreman_resources':
   resources_hash => $resources_hash, 
 }
```
### Sample Usage: Creating a Postgresql hba rule (through Foreman Resources) ###
 
##### In Foreman Resource resources_hash value as yml #####
```
---
postgresql::server::pg_hba_rule:
  allow access from 10.1.172.12:
    description: allow access from 10.1.172.12
    type: host
    database: all
    user: all
    address: 10.1.172.12/32
    auth_method: md5
    order: 2
postgresql::server::db:
  mydatabasename:
    user: mydatabaseuser
    password: postgresql_password(mydatabaseuser,mypassword)
```
