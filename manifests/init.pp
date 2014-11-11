# Class: foreman_resources
#
# This module manages resource creation using puppet defined types in foreman
#
# Parameters: 
# resource_name - any valid defined type in puppet that is available in the puppet module path
# parameters - Parameter hash that needs to be passed into the relevant resource during creation
# default_values - [OPTIONAL] default values for the parameters to be passed during resource creation
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
#   'mydatabasename' => {
#      user => 'mydatabaseuser', 
#      password => postgresql_password('mydatabaseuser', 'mypassword'),
#    }
#  , 
# }
#
# $resource_hash = {
#   'postgresql::server::pg_hba_rule' => $postgresql_hba_hash,
#   'postgresql::server::db' => $postgresql_db_hash,
# }
#
# class { 'foreman_resources':
#   resource_hash => $resource_hash, 
# }
#
class foreman_resources ($resources_hash = undef) {
  $resources_hash.each |$resource_name, $resource_params| {
    create_resources($resource_name, $resource_params)
  }
}
