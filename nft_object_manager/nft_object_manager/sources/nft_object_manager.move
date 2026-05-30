#[allow(duplicate_alias, lint(self_transfer))]
module nft_object_manager::nft_object_manager{
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;

    public struct NFT has key, store{
        id: UID,
        name: vector<u8>,
        description: vector<u8>,
        image_url: vector<u8>,
        creator_info: vector<u8>,
    }

    public fun mint_nft(
        name: vector<u8>,
        description: vector<u8>,
        image_url: vector<u8>,
        creator_info: vector<u8>,
        ctx: &mut TxContext
    ){
        let nft = NFT {
            id: object::new(ctx),
            name,
            description,
            image_url,
            creator_info,
        };

        transfer::public_transfer(nft, tx_context::sender(ctx));

        }

        public fun transfer_nft(
            nft: NFT,
            recipient: address
        ){
            transfer::public_transfer(nft, recipient);
        }

        public fun check_nft_name(nft: &NFT): vector<u8>{
            nft.name
        }
        public fun check_nft_description(nft: &NFT): vector<u8>{
            nft.description
        }
        public fun check_nft_creatorInfo(nft: &NFT): vector<u8>{
            nft.creator_info
        }
    }