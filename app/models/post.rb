class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user

  def fullbody  
		bodysplit = body.split(' ')
		bodyshort = ''
		i = 0
		199.times { |n| bodyshort << bodysplit[n] << " " }
		bodyshort << bodysplit[200]
		"#{bodyshort}..."
  end  

end
