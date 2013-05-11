class CreateTableComments < ActiveRecord::Migration
  def up
    create_table :comments do |t|
      t.string :comment
      t.references :discussion
   end
 end

  def down
    drop_table :comments
  end
end
