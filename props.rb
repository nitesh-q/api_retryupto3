def loldepol
    require 'httparty'
    response = HTTParty.get("http://localhost:8888/auth")
    if response.headers["badsec-authentication-token"].length>0
      return response.headers["badsec-authentication-token"]
    else
      nil
    end
      
end
p=loldepol
print(p)