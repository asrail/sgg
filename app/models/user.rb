class User < ActiveLdap::Base
  ldap_mapping  :dn_attribute => "uid", :prefix => "ou=people", :classes => ['top', 'pessoa']

  def empty
    self.have_attribute?("dn")
  end
end
