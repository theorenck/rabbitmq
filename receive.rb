require "bunny"

conn = Bunny.new(
  :host      => "digging-nildro-hain-2.bigwig.lshift.net",
  :port      => 10713,
  :vhost     => "y49k1-GCfMly",
  :user      => "Fbtg_lMf",
  :pass      => "OTryoUJqivmZFmR9g57o8PTKiuQlmkLj"
)
conn.start

ch   = conn.create_channel
q    = ch.queue("hello")

puts " [*] Waiting for messages in #{q.name}. To exit press CTRL+C"
q.subscribe(:block => true) do |delivery_info, properties, body|
  puts " [x] Received #{body}"

  # cancel the consumer to exit
  delivery_info.consumer.cancel
end