class Group < ActiveLdap::Base
  ldap_mapping :dn_attribute => 'cn', :prefix => 'ou=Groups', :classes => ['top', 'posixGroup', 'sggGroup']
  has_many :members, :class_name => "User", :wrap => "memberUid"
  has_many :coordinators, :class_name => "User", :wrap => "coordinatorUid"

   def coordinator?(user)
    if user.kind_of?String and !user.empty?
      user = User.find(user)
    end

    return self.coordinators.member?user
  end

  def marshal_load(str)
    load(str)
  end
  
  def marshal_dump
    dump
  end
end
