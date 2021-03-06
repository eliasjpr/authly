module Authly
  struct Password
    getter client_id : String,
      client_secret : String,
      username : String,
      password : String,
      scope : String

    def initialize(@client_id, @client_secret, @username, @password, @scope = "")
    end

    def authorize!
      raise Error.unauthorized_client unless client_authorized?
      raise Error.owner_credentials unless owner_authorized?
      Response::AccessToken.new(client_id)
    end

    private def client_authorized?
      Authly.clients.authorized?(client_id, client_secret)
    end

    private def owner_authorized?
      Authly.owners.authorized?(username, password)
    end
  end
end
