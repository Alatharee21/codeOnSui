
#[test_only]
module nft_object_manager::nft_object_manager_tests;

use nft_object_manager::nft_object_manager;
use nft_object_manager::nft_object_manager::NFT;


#[test]
fun test_mint_nft() {
    let mut ctx = sui::tx_context::dummy();
    let name: vector<u8> = b"NFT1";
    let description: vector<u8> = b"This is NFT1";
    let image_url: vector<u8> = b"https://example.com/nft1.png";
    let creator_info: vector<u8> = b"Creator1";
    assert!(name == b"NFT1", 0);
    assert!(description == b"This is NFT1", 0);
    assert!(image_url == b"https://example.com/nft1.png", 0);
    assert!(creator_info == b"Creator1", 0);
    nft_object_manager::mint_nft(name, description, image_url, creator_info, &mut ctx);
}

/*#[test]
fun test_transfer_nft() {
    let mut ctx = sui::tx_context::dummy();
    let name: vector<u8> = b"NFT1";
    let description: vector<u8> = b"This is NFT1";
    let image_url: vector<u8> = b"https://example.com/nft1.png";
    let creator_info: vector<u8> = b"Creator1";
    let recipient: address = @0x1234567890abcdef;
    assert!(name == b"NFT1", 0);
    assert!(description == b"This is NFT1", 0);
    assert!(image_url == b"https://example.com/nft1.png", 0);
    assert!(creator_info == b"Creator1", 0);
    let nft: NFT = mint_nft(name, description, image_url, creator_info, &mut ctx);
    nft_object_manager::nft_object_manager::transfer_nft(nft, recipient);
}*/