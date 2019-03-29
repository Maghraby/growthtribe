class NodesDecorator < Draper::CollectionDecorator
  def to_json
    object.map do |node|
      node.decorate.to_json
    end
  end

  def ids
    object.map do |node|
      node.decorate.ids
    end
  end
end
