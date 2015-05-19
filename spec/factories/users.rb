FactoryGirl.define do
  factory :user do
    email 'admin@mail.md'
    username 'johndoe'
    password 'pass123456'
    password_confirmation 'pass123456'
  end

  # # This will use the User class (Admin would have been guessed)
  # factory :admin, class: User do
  #   first_name "Admin"
  #   last_name  "User"
  #   admin      true
  # end
end
