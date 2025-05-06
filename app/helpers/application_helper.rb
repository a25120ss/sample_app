module ApplicationHelper
  # ページごとの完全なタイトルを返す
  def full_title(page_title = '')#page_titleが追加されてるか否かで挙動が変わる
    base_title = 'Ruby on Rails Tutorial Sample App'
    if page_title.empty?
     return base_title
    else
      return "#{page_title} | #{base_title}"
    end
  end
end
