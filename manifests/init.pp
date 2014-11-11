# Class: foreman_resources
#
# This module manages resource creation using puppet defined types in foreman
#
# Parameters: 
# resources_hash - a hash map of resource names and parameters
#
# Actions:
# create_resource - using puppet 'create_resource' function to create valid puppet resources
#
# Requires: see Modulefile
#
# Sample Usage: Creating a Postgresql hba rule
# $postgresql_hba_hash = {
#    'allow access from 10.1.172.12'  => {
#      description => "allow access from 10.1.172.12", 
#      type => 'host', 
#      database => 'all', 
#      user => 'all', 
#      address => '10.1.172.12/32', 
#      auth_method => 'md5', 
#      order => '002',
#    }
#    ,
# }
#
# $postgresql_db_hash = {
#   'mydatabasename' =>   {
#      user => 'mydatabaseuser', 
#      password => postgresql_password('mydatabaseuser', 'mypassword'),
#    }
#  , 
# }
#
# $resources_hash = {
#   'postgresql::server::pg_hba_rule' => $postgresql_hba_hash,
#   'postgresql::server::db' => $postgresql_db_hash,
# }
#
# class { 'foreman_resources':
#   resources_hash => $resources_hash, 
# }
#
class foreman_resources ($resources_hash = undef) {
  each($resources_hash) |$resource_name, $resource_params| { 
    create_resources($resource_name, $resource_params) 
   }
}
