module hello_sui::marketplaces;

use sui::balance::Balance;
use sui::coin::{Self, Coin};
use sui::object::{Self, UID, last_created};
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

public struct Listing has drop {
    seller: address,
    price: u64,
    list: bool,
    nft: ID,
}

public struct Treasury has key, store {
    id: UID,
    balance: Balance<RASHCOIN>,
}
public struct Marketplace has key, store {
    id: UID,
    fee: u64,
    listings: u64,
}

//Capabilities
public struct AdminCap has key, store {
    id: UID,
}
public struct TreasuryCap has key, store {
    id: UID,
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

public fun list_nft(heroNFT: HeroNFT, listing: &mut Listing, marketplaced: &mut Marketplace) {
    listing.list = true;
    listing.nft = object::id(&heroNFT);
    marketplaced.listings = marketplaced.listings + 1;
    transfer::public_share_object(heroNFT);
}

public fun cancel_listing(_nft: HeroNFT, listing: &mut Listing, marketplace: &mut Marketplace) {
    marketplace.listings = marketplace.listings - 1;
    listing.list = false
}

public fun purchase(
    _payment: Coin<RASHCOIN>,
    listing: &mut Listing,
    marketplace: &mut Marketplace,
    ctx: &mut TxContext,
) {
    collect_fees(listing, marketplace);
    let buyer = tx_context::sender(ctx);
    let nft = listing.nft;
    listing.list = false;
    transfer::public_transfer(nft, buyer);
}

fun collect_fees(listing: &Listing, marketplace: &mut Marketplace): u64 {
    let fee = (listing.price * 2) / 100;
    marketplace.fee = fee;
    fee
}

public fun update_fee(_: &AdminCap, market: &mut Marketplace, fee: u64) {
    market.fee = fee
}

public fun withdraw(_: &TreasuryCap, treasury: &mut Treasury, ctx: &mut TxContext) {
    let team = tx_context::sender(ctx);
    let amount = coin::balance<RASHCOIN>(&treasury.balance);
    let treasure = coin::withdraw<RASHCOIN>(&mut treasury.balance, amount);
    transfer::public_transfer(treasure, team);
}
