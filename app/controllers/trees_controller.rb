class TreesController < BaseController
  def show
    node = Node.find(params[:id])

    render json: node.decorate.to_json
  end

  def parents
    node = Node.find_by!(id: params[:id],
                         tree_id: params[:tree_id])

    render json: node.parents.decorate.ids
  end

  def childrens
    node = Node.find_by!(id: params[:id],
                         tree_id: params[:tree_id])

    render json: node.childrens.decorate.to_json
  end
end
