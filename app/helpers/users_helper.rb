module UsersHelper
  def current_user_diplomas(user)
    user.diplomas.verify(true)
  end
end
