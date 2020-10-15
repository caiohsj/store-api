Given("um usuario da aplicacao") do
  @user = FactoryBot.create(:user)
end

When("ele fornece as credencias validas") do
  @auth = { password: "secret123", email: "diogo@jera.com.br" }
end

When('ele clica no botão para fazer o login') do
  @test_client = TestClient.new
  @user_login_response = @test_client.login('api/v1/users/sign_in', @auth)
end

Then("ele deve estar autorizado a acessar a aplicacao") do
  auth_response = Users::SessionService.call(session_params: @auth)
  expect(auth_response.success?).to be true
end

When("ele fornece as credencias invalidas") do
  @invalid_auth = { password: "senha_errada", email: "diogo@jera.com.br" }
end

Then("ele nao deve estar autorizado a acessar a aplicacao") do
  auth_response = Users::SessionService.call(session_params: @invalid_auth)
  expect(auth_response.success?).to be false
end

Then('o usuario deve ter um HTTP_USER_TOKEN e um HTTP_USER_EMAIL validos') do
  @user.reload
  expect(@test_client.headers['HTTP_USER_TOKEN']).to be_truthy
  expect(@test_client.headers['HTTP_USER_EMAIL']).to be_truthy
  expect(@test_client.headers['HTTP_USER_EMAIL']).to eq(@user.email)
  expect(@user.token_match?(@test_client.headers['HTTP_USER_TOKEN'])).to be_truthy
end
