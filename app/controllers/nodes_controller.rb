class NodesController < ApplicationController
    def create
        nodes = create_params[:nodes]

        if nodes.nil?
            render json: {error: 'Please supply a valid list of nodes'}, status: :bad_request
            return
        end

        blockchain = Blockchain.instance

        nodes.each do |node|
            blockchain.register_node(node)
        end

        response = {
            message: "New nodes have been added",
            total_nodes: blockchain.nodes
        }

        render json: response, status: :created
    end

    def create_params
        params.permit(nodes:[])
    end
end