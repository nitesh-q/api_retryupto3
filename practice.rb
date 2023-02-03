
  require 'httparty'
  require 'digest'
  response = HTTParty.get("http://localhost:8888/auth")
  print(response.headers["badsec-authentication-token"])
  temp = response.headers["badsec-authentication-token"] + "/users"
  lol=Digest::SHA256.hexdigest temp
    response1 = HTTParty.get("http://localhost:8888/users",headers:{"X-Request-Checksum" => lol})
  print(response1)