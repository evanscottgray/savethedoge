def morning_meds

  m = Message.new(@twilioclient)

  m.send(APP_CONFIG['phone_numbers']['primary'], "Hey there Elise! Did you feed Cami her #{APP_CONFIG['medications']['med_1']} and #{APP_CONFIG['medications']['med_2']} this morning?" )

  Thread.new do

    reminders = 0

    until $redis.get('meds_morning') == 'true'
      reminders += 1
      # Sleep 300 seconds before checking again.
      sleep(300)
      if reminders <= 1
        m.send(APP_CONFIG['phone_numbers']['primary'], "Hey there Elise! Did you feed Cami her #{APP_CONFIG['medications']['med_1']} and #{APP_CONFIG['medications']['med_2']} this morning? This is reminder ##{i}." )
      elsif reminders >= 3

        recipients = [APP_CONFIG['phone_numbers']['primary'], APP_CONFIG['phone_numbers']['notifications']].flatten

        recipients.each do | recipient |
          m.send(recipient, "Elise still has yet to feed Cami her #{APP_CONFIG['medications']['med_1']} and #{APP_CONFIG['medications']['med_2']} this morning.")
        end

      end
    end

    recipients = [APP_CONFIG['phone_numbers']['primary'], APP_CONFIG['phone_numbers']['notifications']].flatten
    fortune  = IHeartQuotes::Client.random

    recipients.each do | recipient |
      m.send(recipient, "Elise has fed Cami her medication for this morning @#{Time.now}, great job! ~~ #{fortune.quote}")
    end

  end

end

def evening_meds

  m = Message.new(@twilioclient)

  m.send(APP_CONFIG['phone_numbers']['primary'], "Hey there Elise! Did you feed Cami her #{APP_CONFIG['medications']['med_1']} and #{APP_CONFIG['medications']['med_2']} this evening?" )

  Thread.new do

    reminders = 0

    until $redis.get('meds_evening') == 'true'
      reminders += 1
      # Sleep 300 seconds before checking again.
      sleep(300)
      if reminders <= 1
        m.send(APP_CONFIG['phone_numbers']['primary'], "Hey there Elise! Did you feed Cami her #{APP_CONFIG['medications']['med_1']} and #{APP_CONFIG['medications']['med_2']} this evening?? This is reminder ##{i}." )
      elsif reminders >= 3

        recipients = [APP_CONFIG['phone_numbers']['primary'], APP_CONFIG['phone_numbers']['notifications']].flatten

        recipients.each do | recipient |
          m.send(recipient, "Elise still has yet to feed Cami her #{APP_CONFIG['medications']['med_1']} and #{APP_CONFIG['medications']['med_2']} this evening.")
        end

      end
    end

    recipients = [APP_CONFIG['phone_numbers']['primary'], APP_CONFIG['phone_numbers']['notifications']].flatten
    fortune  = IHeartQuotes::Client.random

    recipients.each do | recipient |
      m.send(recipient, "Elise has fed Cami her medication for this evening! @#{Time.now}, great job! ~~ #{fortune.quote}")
    end

  end

end