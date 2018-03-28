module ApplicationHelper
  def paginate objects, options = {}
    options.reverse_merge!( theme: 'twitter-bootstrap-3' )
    super( objects, options )
  end

  def current_conversation user_id
    Conversation.current_conversation(user_id)[0].id
  end
end
