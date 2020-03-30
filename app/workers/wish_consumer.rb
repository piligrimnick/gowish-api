class WishConsumer
  include Sneakers::Worker
  from_queue 'gowish.wishes.incoming.telegram'

  def work(message)
    wish = Wishes::CreateFromTelegram.call(JSON.parse(message))

    worker_trace "Wish saved with id: #{wish.id}"
    ack!
  end
end
