module hello_sui::achievement_badge;

use std::string::String;
use sui::event;
use sui::object::{Self, UID};
use sui::transfer;
use sui::tx_context::{Self, TxContext};
use sui::url::Url;

public struct BadgeCollection has key, store {
    id: UID,
    supply: u64,
}

public struct BadgeNFT has key, store {
    id: UID,
    title: String,
    description: String,
    rarity: u64,
    image_url: Url,
}

public struct BadgeMinted has copy, drop {
    title: String,
    description: String,
    rarity: u64,
    image_url: Url,
}

public fun mint_badge(
    title: String,
    description: String,
    rarity: u64,
    image_url: Url,
    ctx: &mut TxContext,
    badge_collection: &mut BadgeCollection,
) {
    mint_badges(title, description, rarity, image_url, ctx);
    nft_supply_increase(badge_collection);
}

public fun transfer_badge(badge_nft: BadgeNFT, recipient: address) {
    transfer::public_transfer(badge_nft, recipient);
}

public fun upgrade_badge(badge_nft: &mut BadgeNFT) {
    badge_nft.rarity = badge_nft.rarity * 4
}

//Helper functions
fun mint_badges(
    title: String,
    description: String,
    rarity: u64,
    image_url: Url,
    ctx: &mut TxContext,
) {
    let minter = tx_context::sender(ctx);
    let badge_nft = BadgeNFT {
        id: object::new(ctx),
        title,
        description,
        rarity,
        image_url,
    };
    transfer::public_transfer(badge_nft, minter);
    nft_minted(title, description, rarity, image_url);
}

fun nft_supply_increase(badge_collection: &mut BadgeCollection) {
    badge_collection.supply = badge_collection.supply + 1
}

fun nft_minted(title: String, description: String, rarity: u64, image_url: Url) {
    event::emit(BadgeMinted {
        title,
        description,
        rarity,
        image_url,
    })
}
