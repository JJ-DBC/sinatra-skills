get '/' do
  # render home page
  @users = User.all

  erb :index
end

#----------- SESSIONS -----------

get '/sessions/new' do
  # render sign-in page
  @email = nil
  erb :sign_in
end

post '/sessions' do
  # sign-in
  # variable assignment - @email = the email the user submitted in the form
  @email = params[:email]
  # return nil or user depending on success/fail authentication
  user = User.authenticate(@email, params[:password])
  # if user has authenticated
  if user
    # successfully authenticated; set up session and redirect
    session[:user_id] = user.id
    # redirect to home page
    redirect '/'
  else
    # an error occurred, re-render the sign-in form, displaying an error
    @error = "Invalid email or password."
    erb :sign_in
  end
end

delete '/sessions/:id' do
  # sign-out -- invoked via AJAX
  return 401 unless params[:id].to_i == session[:user_id].to_i
  session.clear
  200
end


#----------- USERS -----------

get '/users/new' do
  # render sign-up page
  @user = User.new
  erb :sign_up
end

post '/users' do
  # sign-up
  @user = User.new params[:user]
  if @user.save
    # successfully created new account; set up the session and redirect
    session[:user_id] = @user.id
    redirect '/'
  else
    # an error occurred, re-render the sign-up form, displaying errors
    erb :sign_up
  end
end

get '/users' do
  redirect to '/' if session[:user_id].nil?
  erb :profile
end

get '/users/proficiencies/:proficiency_id/edit' do
  # a form for the users to edit their proficiency
end

post '/users/proficiencies/:proficiency_id' do
  # update the record
end

get '/users/proficiencies/new' do
  # form to create a new proficiency for the user
end

post '/users/proficiencies' do
  # create the proficiency, this may include creating the skill
end
