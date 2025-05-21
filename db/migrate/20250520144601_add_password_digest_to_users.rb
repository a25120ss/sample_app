class AddPasswordDigestToUsers < ActiveRecord::Migration[7.0]
  def change #ファイル名を規約にのっとって書けば自動生成してくれる(COC)
    add_column :users, :password_digest, :string
  end
end
