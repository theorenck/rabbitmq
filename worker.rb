require "bunny"

conn = Bunny.new(
  :host      => "digging-nildro-hain-2.bigwig.lshift.net",
  :port      => 10713,
  :vhost     => "y49k1-GCfMly",
  :user      => "Fbtg_lMf",
  :pass      => "OTryoUJqivmZFmR9g57o8PTKiuQlmkLj"
)
conn.start

ch = conn.create_channel
q = ch.queue("task_queue", :durable => true)

ch.prefetch(1)
puts " [*] Waiting for messages. To exit press CTRL+C"

begin
  q.subscribe(:ack => true, :block => true) do |delivery_info, properties, body|
    puts " [x] Received '#{body}'"
    # imitate some work
    sleep 1.0
    puts " [x] Done"
    ch.ack(delivery_info.delivery_tag)
  end
rescue Interrupt => _
  conn.close
end