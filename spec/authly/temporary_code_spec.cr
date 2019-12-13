require "../spec_helper"

module Authly
  describe TemporaryCode do
    context "when request is authorized" do
      request = build_temporary_code

      it "creates a temporary code request object" do
        auth_code = TemporaryCode.new(request)
        auth_code.should be_a TemporaryCode
        auth_code.state.should eq request.state
        auth_code.code.should eq Token.write(request.client_id, request.redirect_uri.to_s, 1.minute.from_now.to_unix)
      end
    end
  end
end
