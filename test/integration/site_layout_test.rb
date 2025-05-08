require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test 'layout links' do
    get root_path # GET /
    assert_template 'static_pages/home' #homeテンプレートが表示されているか
    assert_select 'a[href=?]', root_path, count: 2 # root_pathへのリンクが2つあるはず
    assert_select 'a[href=?]', help_path
    assert_select 'a[href=?]', about_path
    assert_select 'a[href=?]', contact_path
  end
end
