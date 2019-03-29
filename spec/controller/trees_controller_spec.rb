require 'rails_helper'

RSpec.describe 'TreesController', type: :request do
  include_context 'API Context'

  let!(:tree_node) { FactoryBot.create :node, id: 1, tree_id: 1}
  let!(:tree_node_childrens) do
    (1..5).each do |i|
      node = FactoryBot.create :node, id: i+1, tree_id: 1
      FactoryBot.create :children_node, node_id: tree_node.id, children_id: node.id
    end
  end

  describe "#show" do
    context "Not found" do
      it 'Should return error tree not found' do
        get '/121212'
        expect(response.status).to eq 404
        expect(payload['message']).to eq 'Node not found'
      end
    end

    context "Tree exists" do
      expected_response = {
        "id"=>1,
        "child"=>[
          {"id"=>2, "child"=>[]},
          {"id"=>3, "child"=>[]},
          {"id"=>4, "child"=>[]},
          {"id"=>5, "child"=>[]},
          {"id"=>6, "child"=>[]}
        ]
      }
      it 'Should return tree not found' do
        get '/1'
        expect(response.status).to eq 200
        expect(payload).to eq expected_response
      end
    end
  end

  describe "#parents" do
    context "Not found" do
      it 'Should return error when tree not found' do
        get '/121212/parent/7'
        expect(response.status).to eq 404
        expect(payload['message']).to eq 'Node not found'
      end

      it 'Should return error when node not found' do
        get '/1/parent/100'
        expect(response.status).to eq 404
        expect(payload['message']).to eq 'Node not found'
      end
    end

    context "Node exists" do
      it 'Should return parent id' do
        get '/1/parent/6'
        expect(response.status).to eq 200
        expect(payload).to eq [{'id'=>1}]
      end
    end

    context "When have two parent" do
      let!(:node) { FactoryBot.create :node, id: 7, tree_id: 1}
      let!(:tree_node_children) do
        FactoryBot.create :children_node, node_id: tree_node.id, children_id: node.id
        FactoryBot.create :children_node, node_id: 6, children_id: node.id
      end
      it 'Should return parent id' do
        get '/1/parent/7'
        expect(response.status).to eq 200
        expect(payload).to eq [{'id'=>1}, {'id'=>6}]
      end
    end
  end

  describe "#childrens" do
    context "Not found" do
      it 'Should return error when tree not found' do
        get '/121212/child/7'
        expect(response.status).to eq 404
        expect(payload['message']).to eq 'Node not found'
      end

      it 'Should return error when node not found' do
        get '/1/child/100'
        expect(response.status).to eq 404
        expect(payload['message']).to eq 'Node not found'
      end
    end

    context "Node exists" do
      let!(:child1) { FactoryBot.create :node, id: 7, tree_id: 1}
      let!(:child2) { FactoryBot.create :node, id: 8, tree_id: 1}
      let!(:tree_node_children) do
        FactoryBot.create :children_node, node_id: 6, children_id: child1.id
        FactoryBot.create :children_node, node_id: 6, children_id: child2.id
      end

      context 'Child one level' do
        it 'Should return childrens' do
          get '/1/child/6'
          expect(response.status).to eq 200
          expect(payload).to eq [{"id"=>7, "child"=>[]}, {"id"=>8, "child"=>[]}]
        end
      end

      fcontext 'Child two level' do
        let!(:child71) { FactoryBot.create :node, id: 9, tree_id: 1}
        let!(:child9) { FactoryBot.create :node, id: 10, tree_id: 1}
        let!(:node7_childrens) do
          FactoryBot.create :children_node, node_id: 7, children_id: child71.id
          FactoryBot.create :children_node, node_id: 9, children_id: child9.id
        end
        it 'Should return childrens' do
          expected_response = [{
            "id"=>7, 
            "child"=>[{"id"=>9, "child"=>[{"id"=>10, "child"=>[]}]}]},
            {"id"=>8, "child"=>[]
          }]
          get '/1/child/6'
          expect(response.status).to eq 200
          expect(payload).to eq expected_response
        end
      end
    end
  end
end