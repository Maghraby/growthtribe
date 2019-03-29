class CreateNodes < ActiveRecord::Migration[5.1]
  def change
    create_table :nodes do |t|
      t.integer 'tree_id', null: true
      t.index ['tree_id'], name: 'index_node_on_tree_id'

      t.timestamps
    end
  end
end
