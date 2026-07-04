module hello_sui::marketplaces;

use sui::balance::Balance;
use sui::coin::Coin;
use sui::object::{Self, UID};
use sui::transfer;
use sui::tx_context::{Self, TxContext};
use sui::url::Url;

//Coin
public struct RASHCOIN has drop {}

//Objects
public struct HeroNFT has key, store {
    id: UID,
    title: vector<u8>,
    description: vector<u8>,
    rarity: u64,
    image_url: Url,
}

public struct Listing has key, store {
    id: UID,
    seller: address,
    price: u64,
    list: bool,
    nft: HeroNFT,
}

public struct Treasury has key, store {
    id: UID,
    balance: Balance<RASHCOIN>,
}
public struct Marketplace has key, store {
    id: UID,
    fee: u64,
    listings: u64,
    vault: address,
}

//Events
public struct NFTListed has copy, drop {
    price: u64,
    list: bool,
}

public struct NFTPurchased has copy, drop {
    price: u64,
    title: vector<u8>,
    buyer: address,
    seller: address,
}

public struct ListingCancelled has copy, drop {
    list: bool,
}

public fun list_nft(
    seller: address,
    price: u64,
    list: bool,
    nft: HeroNFT,
    ctx: &mut TxContext,
    marketplaced: &mut Marketplace,
) {
    let marketplace = marketplaced.vault;
    let listing = Listing {
        id: object::new(ctx),
        seller,
        price,
        list,
        nft,
    };
    transfer::public_transfer(listing, marketplace);
}

public fun cancel_listing(
    _nft: &HeroNFT,
    listing: &mut Listing,
    marketplace: &mut Marketplace,
): bool {
    marketplace.listings = marketplace.listings - 1;
    listing.list == false
}

public fun purchase(
    _payment: Coin<RASHCOIN>,
    listing: Listing,
    marketplace: &mut Marketplace,
    ctx: &mut TxContext,
) {
    collect_fees(&listing, marketplace);

    let Listing { nft, .. } = listing;
    let buyer = tx_context::sender(ctx);
    transfer::public_transfer(nft, buyer);
}

fun collect_fees(listing: &Listing, marketplace: &mut Marketplace): u64 {
    let fee = (listing.price * 2) / 100;
    marketplace.fee = fee;
    fee
}
