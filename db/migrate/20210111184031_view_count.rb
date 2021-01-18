class ViewCount < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :view_count, :integer
  end
end
