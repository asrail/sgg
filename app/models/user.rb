class User < ActiveLdap::Base
  ldap_mapping  :dn_attribute => "uid", :prefix => "ou=Users", :classes => ['top', 'person', 'shadowAccount', 'simpleSecurityObject']
  belongs_to :groups, :class_name => 'Group', :many => 'memberUid'

  def empty
    self.have_attribute?("dn")
  end
end
