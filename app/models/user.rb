class User < ApplicationRecord
    
    has_many :questions, dependent: :nullify
    has_many :answers, dependent: :nullify
    
    has_secure_password
    # It's a In-built method in rails. It combines pswd and pswd_confirmation field and
    # convert it into hash and store it in password_digest column in db
    # Provide user authentication feature on the model that it is called in
    # It requires a password_digest as a column in db and a gem bcrypt as well
    # bcrypt is a password-hashing function 
    # it will add a presence validation for the password field
    # 👇🏻Sign up
    # it cross verify the 'password' with 'password confirmation' text field
    # 👇🏻Sign In
    # it creates method 'authenticate' to verify password. if called with correct password it will retrun 'true' else 'false'

    def full_name
        "#{first_name} #{last_name}"
    end
end
