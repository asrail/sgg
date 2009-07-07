class User < ActiveLdap::Base
  ldap_mapping  :dn_attribute => "uid", :prefix => "ou=Users", :classes => ['top', 'person', 'shadowAccount', 'simpleSecurityObject']
  belongs_to :groups, :class_name => 'Group', :many => 'memberUid'

  def empty
    self.have_attribute?("dn")
  end

  def self.authenticate(username, password)
    return false if username.empty? or password.empty?
    find(username).authenticated?(password)
  rescue ActiveLdap::EntryNotFound
    return false
  end

  def authenticated?(password)
    bind(password)
    remove_connection
    true
  rescue ActiveLdap::AuthenticationError, ActiveLdap::LdapError::UnwillingToPerform
    false
  end
end
