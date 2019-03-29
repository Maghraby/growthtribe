class CreateChildrenNode < ActiveRecord::Migration[5.1]
  def change
    create_table :children_nodes do |t|
      t.integer 'node_id'
      t.integer 'children_id'
      t.index ['children_id'], name: 'index_children_nodes_on_children_id'
      t.index ['node_id'], name: 'index_children_nodes_on_node_id'

      t.timestamps
    end
  end
end
