require '../PolyNotify'

client = PolyNotify::Client.new
client.log_in
client.get_resultats_finaux
client.save_checksum

puts client.last_checksum