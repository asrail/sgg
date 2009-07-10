class Group < ActiveLdap::Base
  ldap_mapping :dn_attribute => 'cn', :prefix => 'ou=Groups', :classes => ['top', 'posixGroup', 'sggGroup']
  has_many :members, :class_name => "User", :wrap => "memberUid"
  has_many :coordinators, :class_name => "User", :wrap => "coordinatorUid"

  def marshal_load(str)
    load(str)
  end
  
  def marshal_dump
    dump
  end
end
