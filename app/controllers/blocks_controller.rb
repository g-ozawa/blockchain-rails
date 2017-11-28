class BlocksController < ApplicationController
    def index
        blockchain = Blockchain.instance
        chain = blockchain.chain
        response = {
            chain: chain,
            length: chain.size,
        }

        render json: response, status: :ok
    end

    def create
        blockchain = Blockchain.instance

        last_block = blockchain.last_block
        last_proof = last_block[:proof]
        proof = blockchain.proof_of_work(last_proof)

        blockchain.new_transaction("0", request.host, 100)

        block = blockchain.new_block(proof)

        response = {
            message: "New Block Forged",
            index: block[:index],
            transactions: block[:transactions],
            proof: block[:proof],
            previous_hash: block[:previous_hash],
        }

        render json: response, status: :ok
    end

    def update_all
        blockchain = Blockchain.instance
        
        replaced = blockchain.resolve_conflicts

        if replaced
            response = {
                message: "Our chain was replaced",
                new_chain: blockchain.chain
            }
        else
            response = {
                message: "Our chain is authoritative",
                chain: blockchain.chain
            }
        end

        render json: response, status: :ok
    end
end