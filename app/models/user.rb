class User < ActiveLdap::Base
  ldap_mapping  :dn_attribute => "uid", :prefix => "ou=Users", :classes => ['top', 'person', 'shadowAccount', 'simpleSecurityObject']
  belongs_to :groups, :class_name => 'Group', :many => 'memberUid'

  def self.authenticate(username, password)
    return false if username.empty? or password.empty?
    find(username).bind(password)
    remove_connection
    return true
  rescue ActiveLdap::EntryNotFound, ActiveLdap::AuthenticationError, ActiveLdap::LdapError::UnwillingToPerform
    return false
  end
  
  def marshal_load(str)
    load(str)
  end
  
  def marshal_dump
    dump
  end
  
end
