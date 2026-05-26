module hello_sui::nft{
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    public struct NFT has key, store{
        id: UID,
        name: vector<u8>,
    }

    entry fun mint_nft(
        name: vector<u8>,
        ctx: &mut TxContext /*&mut means it is a mutable reference*/
    ){
        let nft = NFT{
            id: object::new(ctx),
            name,
        };
        
        transfer::public_transfer(nft, tx_context::sender(ctx));
    }

    entry fun send_nft(
        nft: NFT,
        recipient: address
    ){
        transfer::public_transfer(nft, recipient);
    }

    public fun get_nft_Name(nft: &NFT/*& means it is immutable reference*/): vector<u8>{
        nft.name
    }
}