class Transactional < ActionMailer::Base
  default :from => "bot@pictorical.com", :return_path => 'bot@pictorical.com'

  def welcome(book)
    @user = book.user
    @book = book
    mail :to => @user.email
  end
  
  
end
