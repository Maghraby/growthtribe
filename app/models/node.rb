class Node < ApplicationRecord
  has_many :children_nodes
  has_many :childrens, through: :children_nodes

  has_many :parent_nodes, foreign_key: :children_id, class_name: 'ChildrenNode'
  has_many :parents, through: :parent_nodes, source: :node

  has_one :tree, foreign_key: :tree_id, class_name: 'Node'

  after_commit on: [:update] do |record|
    
  end

  def redis_parents
    return JSON.parse(REDIS.get(parents_key)) if REDIS.exists(parents_key)

    decorated_parents = parents.decorate.to_json

    return decorated_parents if decorated_parents.empty?

    REDIS.set(parents_key, decorated_parents)

    decorated_parents
  end

  %w[parents childrens].each do |relations|
    define_method "redis_#{relations}" do
      key = send("#{relations}_key")
      return JSON.parse(REDIS.get(key)) if REDIS.exists(key)

      decorated = send(relations.to_s).decorate.to_json

      return decorated if decorated.empty?

      REDIS.set(key, decorated.to_json)

      decorated
    end

    define_method "#{relations}_key" do
      "#{relations}-#{id}"
    end
  end
end
