class Message

  def initialize(client)

    @client = client

  end

  def send number, message

    @client.account.messages.create(
        :from => '+12107142689',
        :to => number,
        :body => message
    )

  end



end