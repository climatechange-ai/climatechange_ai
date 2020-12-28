require 'csv'
require 'dotenv'
require 'mailgun-ruby'
require 'onetime/api'

Dotenv.load

onetime = Onetime::API.new ENV['ONETIME_EMAIL'], ENV['ONETIME_API_KEY']
mailgun = Mailgun::Client.new ENV['MAILGUN_API_KEY']

existing_emails = mailgun.get('/domains/climatechange.ai/credentials').to_h['items'].map do |cred|
  cred['login']
end

CSV.read('./core_team_info.csv', headers: true).each do |row|
  ccai_login = row['CCAI email id ({}@climatechange.ai)']
  ccai_email = "#{ccai_login}@climatechange.ai"
  orig_email = row['Preferred non-CCAI email address for internal/external emails']

  puts "Checking credentials for #{ccai_login}"

  if orig_email.to_s.strip == ""
    puts "\nSkipping because the row is blank"
  elsif existing_emails.include?(ccai_email)
    puts "\nSkipping Mailgun credential creation for #{ccai_login} since it already exists"
  else
    password = SecureRandom.urlsafe_base64(24)

    puts "\nCreating Mailgun credential..."

    credential = mailgun.post('/domains/climatechange.ai/credentials', {
      login: ccai_login,
      password: password
    })

    puts "Created Mailgun credential:"
    puts credential.to_h

    puts "\nSending password via onetimesecret..."

    secret = onetime.post '/share', {
      secret: "Here is your password to set up your CCAI email at #{ccai_email}:\n\n#{password}\n\nPlease copy this and follow the instructions at https://docs.google.com/document/d/1m5gIZdb-TS56i50VNUaHez4maqNAw7IfOMvhp7Bw-M0. Don't close this window until you've completed the instructions, as the password will only be visible once :)",
      recipient: orig_email,
      ttl: 60*60*24*14
    }

    puts "Sent onetimesecret:"
    puts secret
  end
end
