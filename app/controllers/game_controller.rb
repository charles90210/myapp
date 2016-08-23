class GameController < ApplicationController
  #creates a method try that is called to run the game

  #create a method named start for the start of the game
  def start
    #create a variable name to collect the name entered in the form
    @name = params[:name]
    #set a cookie to hold the users name
    session[:name] = @name
    #creates a variable cookie with a secret random number, sets this as a cookie in the broswer and allows you to have the random number as the same until the game starts over.
    session[:secret_number] = Random.rand(1 .. 50)
    #creates a varible to count the number of tries and set it to zero
    session[:num_tries] = 0
    #put number of tries in cookie

    render "try.html.erb"

  end #end start method



  def try

    #get the name cookie
    @name = session[:name]
    #get the secret number cookie
    @secret_number = session[:secret_number]
    #creates a variable for number of tries and assigns the cookie value to it
    @num_tries = session[:num_tries].to_i
    #increments the number of tries by one
    @num_tries = @num_tries + 1
    #resets the value of the cookie to the value of the num_tries variable
    session[:num_tries] = @num_tries
    #create a variable for the users guess
    user_guess = params[:guess].to_i
    #creates a vairable for the result outcome
    @result = ""
    #writes an if statement checking for the number of tries and dispalying a statement for each outcome

    if user_guess > session[:secret_number].to_i
      @result = "number too high, try again"
      render "result.html.erb"
      #elsif statement compares the number of tries and increments it by one
    elsif user_guess < session[:secret_number].to_i
      @result =  "number too low, try again"
      render "result.html.erb"
      #else statement that displays a statement when the user guesses the secret number correctly
    else user_guess == session[:secret_number].to_i
      @result =  "Congratulations you win!!"
      render "win.html.erb"
    end


  end # end of def try
end # end of class
