require "bunny"

# amqp://Fbtg_lMf:OTryoUJqivmZFmR9g57o8PTKiuQlmkLj@digging-nildro-hain-2.bigwig.lshift.net:10713/y49k1-GCfMly
conn = Bunny.new(
  :host      => "digging-nildro-hain-2.bigwig.lshift.net",
  :port      => 10713,
  :vhost     => "y49k1-GCfMly",
  :user      => "Fbtg_lMf",
  :pass      => "OTryoUJqivmZFmR9g57o8PTKiuQlmkLj"
)
conn.start

ch   = conn.create_channel
q    = ch.queue("task_queue", :durable => true)

msg  = ARGV.empty? ? "Hello World!" : ARGV.join(" ")

q.publish(msg, :persistent => true)
puts " [x] Sent #{msg}"

sleep 1.0
conn.close