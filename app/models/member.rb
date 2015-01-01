class Member < User
  # attr_accessible :title, :body

  def self.join(user)
	# puts "email sanity check #{email}"
	# TODO - generate a crazy long werid passsword.. and send them a welcome
	# email as well as a means of logging in to see purchases associated with their email
	# maybe just allow anyone's email to be searched and see purchase... transparency!
	if user.id 
	  @this = Member.find(user.id)
	end
	if @this ||= self.create!(:email => user.email, :password => "foobarawesome#{rand(5)}", :member => true)
	  return @this, "success"
	end
  end
end
	