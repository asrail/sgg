class Group < ActiveLdap::Base
  ldap_mapping :dn_attribute => 'cn', :prefix => 'ou=Groups', :classes => ['top', 'posixGroup']
  has_many :members, :class_name => "User", :wrap => "memberUid"

  def marshal_load(str)
    load(str)
  end
  
  def marshal_dump
    dump
  end
end
