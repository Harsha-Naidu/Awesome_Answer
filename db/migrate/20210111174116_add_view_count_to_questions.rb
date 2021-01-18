class AddViewCountToQuestions < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :view_count, :integer
  end
end

=begin
-   `:binary`
-   `:boolean`
-   `:date`
-   `:datetime`
-   `:decimal`
-   `:float`
-   `:integer`
-   `:bigint`
-   `:primary_key`
-   `:references`
-   `:string`
-   `:text`
-   `:time`
-   `:timestamp`
=end