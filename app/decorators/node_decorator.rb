class NodeDecorator < Draper::Decorator
  delegate_all

  def to_json
    response = as_json(only: %i[id])
    response[:child] = redis_childrens || childrens.decorate.to_json

    response
  end

  def ids
    as_json(only: %i[id])
  end
end
