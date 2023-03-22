namespace :user do
  desc 'TODO'
  task create: :environment do
    puts 'You will be prompted to details to create new User'
    puts 'Enter an email address: '
    email = $stdin.gets
    puts 'Enter a password: '
    password = $stdin.gets
    unless email.strip!.blank? || password.strip!.blank?
      user = User.new(email: email, password: password, password_confirmation: password)
      if user.save
        puts 'User was created successfully.'
      else
        puts 'Sorry, the user was not created!'
        puts user.errors.full_messages
      end
    end
  end
end
