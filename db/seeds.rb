# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'httparty'

def fetch
  JSON.parse(HTTParty.get('https://random-tree.herokuapp.com').body)
      .with_indifferent_access
rescue JSON::ParserError, TypeError => e
  {}
end

def create_node(node_data, tree_node_id, parent = nil)
  node = Node.find_or_create_by!(id: node_data[:id], tree_id: tree_node_id)
  parent.childrens << node if parent

  node_data[:child].each do |single|
    create_node single, tree_node_id, node
  end
end

data = fetch

create_node data, data[:id]
