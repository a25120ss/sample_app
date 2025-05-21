class CreateUsers < ActiveRecord::Migration[7.0]
  # マイグレーションファイルは実行して初めてDBに反映される（rubyと別世界)
  def change
    create_table :users do |t|
      t.string :name
      t.string :email

      t.timestamps # マジックカラム
    end
  end
end
