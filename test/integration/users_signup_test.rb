require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # 失敗パターンのテスト
  test 'invalid signup information' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: '',
                                         email: 'user@invalid',
                                         password: 'foo',
                                         password_confirmation: 'bar' } }
    end
    assert_response :unprocessable_entity
    assert_template 'users/new'
  end
  # 成功パターンのテスト
  test 'valid signup information' do
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: 'Example User',
                                         email: 'user@example.com',
                                         password: 'password',
                                         password_confirmation: 'password' } }
    end
    follow_redirect! # GET /users/:id  &破壊的メソッド（元に戻れないっていう注意喚起慣習）
    assert_template 'users/show'
  end
end
