require 'test_helper'

class AccountsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:mike)
  end

  test 'should show' do
    get account_path, headers: { 'AuthToken' => @user.auth_token }, as: :json

    parsed_body = JSON.parse response.body

    assert_response :success
    assert_equal @user.email, parsed_body['user']['email']
  end

  test 'should update and render show' do
    patch account_path, params: { user: { address: 'tarasy2' }},
                        headers: { 'AuthToken' => @user.auth_token }, as: :json

    assert_response :success
    assert_equal 'tarasy2', @user.reload.address
  end

  test 'should return unauthorized if no auth_token in header' do
    get root_path, as: :json

    assert_response :unauthorized
  end

  test 'should return unauthorized if auth_token is invalid' do
    get root_path, headers: { 'AuthToken' => SecureRandom.hex }, as: :json

    assert_response :unauthorized
  end
end