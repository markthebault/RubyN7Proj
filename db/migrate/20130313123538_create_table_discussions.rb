class CreateTableDiscussions < ActiveRecord::Migration
  def up
    create_table :discussions do |t|
      t.string :title
      t.text :content
      t.references :user
   end
  end

  def down
    drop_table :discussions
  end
end
