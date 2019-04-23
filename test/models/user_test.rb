require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(email: 'user@example.com', auth_token: 'aad')
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'email should be present' do
    @user.email = ' '
    assert @user.invalid?
    @user.email = nil
    assert @user.invalid?
  end

  test 'auth_token should be present' do
    @user.auth_token = ' '
    assert @user.invalid?
    @user.auth_token = nil
    assert @user.invalid?
  end

  test 'associated task-list should be destroyed' do
    @user.save
    @user.task_lists.create!(name: 'Lorem ipsum', status: 'in')
    assert_difference 'TaskList.count', -1 do
      @user.destroy
    end
  end
end
