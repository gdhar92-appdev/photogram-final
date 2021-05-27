class UsersController < ApplicationController
  def index
    matching_users = User.all

    @list_of_users = matching_users.order({ :username => :asc })

    render({ :template => "users/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_users = User.where({ :id => the_id })

    @the_user = matching_users.at(0)

    render({ :template => "users/show.html.erb" })
  end

  def create
    the_user = User.new
    the_user.comments_count = params.fetch("query_comments_count")
    the_user.email = params.fetch("query_email")
    the_user.likes_count = params.fetch("query_likes_count")
    the_user.password_digest = params.fetch("query_password_digest")
    the_user.private = params.fetch("query_private", false)
    the_user.username = params.fetch("query_username")

    if the_user.valid?
      the_user.save
      redirect_to("/users", { :notice => "User created successfully." })
    else
      redirect_to("/users", { :notice => "User failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_user = User.where({ :id => the_id }).at(0)

    the_user.comments_count = params.fetch("query_comments_count")
    the_user.email = params.fetch("query_email")
    the_user.likes_count = params.fetch("query_likes_count")
    the_user.password_digest = params.fetch("query_password_digest")
    the_user.private = params.fetch("query_private", false)
    the_user.username = params.fetch("query_username")

    if the_user.valid?
      the_user.save
      redirect_to("/users/#{the_user.id}", { :notice => "User updated successfully."} )
    else
      redirect_to("/users/#{the_user.id}", { :alert => "User failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_user = User.where({ :id => the_id }).at(0)

    the_user.destroy

    redirect_to("/users", { :notice => "User deleted successfully."} )
  end

  def sign_in
    render({ :template => "users/user_sign_in.html.erb"})
  end

  def sign_up
    render({ :template => "users/user_sign_up.html.erb"})
  end

  def sign_out
    reset_session
    redirect_to("/")
  end

  def authenticate
    
    user_email = params.fetch("input_email")
    pw = params.fetch("input_password")

    the_user = User.where({:email => user_email}).at(0)

    if the_user == nil
      redirect_to("/user_sign_in", {:alert => "Username does not exist"})
    else
      if the_user.authenticate(pw)
        session.store(:user_id, the_user.id)
        redirect_to("/")
      else
        redirect_to("/user_sign_in", {:alert => "Incorrect Password"})
      end
    end

  end

  def create
    user = User.new
    
    user.email = params.fetch("input_email")
    user.password = params.fetch("input_password")
    user.password_confirmation = params.fetch("input_password_confirmation")
    user.username = params.fetch("input_username")
    user.private = params.fetch("input_private")

    save_status = user.save

    if save_status == true
      session.store(:user_id, user.id)
      redirect_to("/", { :notice => "User account created successfully."})
    else
      redirect_to("/user_sign_up", { :alert => user.errors.full_messages.to_sentence})
    end
    
  end

end
