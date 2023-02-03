def authenticate
    require 'httparty'
    response = HTTParty.get("http://localhost:8888/auth")
    if response.headers["badsec-authentication-token"].length>0
     return response.headers["badsec-authentication-token"]
    else
     return nil
    end
end

def get_user(token)
    require 'httparty'
    require 'digest'
    temp = token + "/users"
    hashing=Digest::SHA256.hexdigest temp
    response = HTTParty.get("http://localhost:8888/users",headers:{"X-Request-Checksum" => hashing })
    
    if response.length>0
     return response
    else
     return nil
    end
end


def retryable
  tries ||= 2
  yield
rescue
  retry unless (tries -= 1).zero?
end

token=retryable {authenticate}

if token==nil
    print("tried two times authenticate ")
    exit(1)
end

users=retryable {get_user(token)}

if users==nil
    print("tried two times to get users")
    exit(1)
end

x1=users.length
x2=0
ar=[]
data=''
while x2<=x1
  
  if users[x2]!=nil && users[x2]!="\n"
    pp=users[x2].to_s
    data+=pp
  else
    ar.push(data)
    data=""
  end
  x2+=1
end
  
print(ar)


