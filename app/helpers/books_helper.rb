module BooksHelper
  
  def last_action
    hidden_field_tag :last_action, @action
  end
  
end
