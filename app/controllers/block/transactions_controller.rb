class Block::TransactionsController < ApplicationController
    def create
        sender, recipient, amount = create_params.values_at(:sender, :recipient, :amount)

        blockchain = Blockchain.instance
        index = blockchain.new_transaction(sender, recipient, amount)

        response = {'message': "Transaction will be added to Block #{index}"}
        render json: response, status: :created
    end

    def create_params
        params.permit(:sender, :recipient, :amount)
    end
end