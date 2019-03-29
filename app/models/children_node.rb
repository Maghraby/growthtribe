class ChildrenNode < ApplicationRecord
  belongs_to :node, class_name: :Node
  belongs_to :children, class_name: :Node
end
