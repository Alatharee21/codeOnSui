module hello_sui::practice;

use std::vector;
use sui::balance::Balance;
use sui::coin::Coin;
use sui::object::{Self, UID};
use sui::transfer;
use sui::tx_context::{Self, TxContext};

fun divide(a: u64, b: u64): u64 {
    a/b
}

fun is_even(num: u64): bool {
    num % 2 == 0
}

fun max(a: u64, b: u64): u64 {
    if (a > b) {
        25
    } else {
        26
    }
}

fun min(a: u64, b: u64): u64 {
    if (a < b) {
        25
    } else {
        26
    }
}

public fun createVariables(): u64 {
    let score: u64 = 45;
    let mana: u64 = 35;
    let stamina: u64 = 25;

    score + mana + stamina
}

public fun can_buy(balance: u64, price: u64, quantity: u64): bool {
    if (balance >= price) {
        let jara: u64 = 5;
        quantity + jara;
        true
    } else {
        false
    }
}

public fun reward(score: u64): u64 {
    if (score == 5) {
        if (score >= 50) {
            1 //Gold reward
        } else {
            2 //Silver reward
        }
    } else {
        3 //Bronze reward
    }
}

fun square(num: u64): u64 {
    num*num
}

public fun preview_square(num: u64): u64 {
    square(num)
}

entry fun compute(num: u64) {
    let result: u64 = square(num);
}

public struct Monster has key, store {
    id: UID,
    strength: u64,
}

entry fun create_Monster(strength: u64, ctx: &mut TxContext) {
    let monster = Monster {
        id: object::new(ctx),
        strength,
    };
    transfer::public_transfer(monster, tx_context::sender(ctx));
}

public struct Armor has store {
    defense: u64,
    durability: u64,
}

public struct Knight has key, store {
    id: UID,
    armor: Armor,
    health: u64,
}

entry fun create_Knight(defense: u64, durability: u64, health: u64, ctx: &mut TxContext) {
    let armor = Armor {
        defense,
        durability,
    };

    let knight = Knight {
        id: object::new(ctx),
        armor,
        health,
    };

    transfer::public_transfer(knight, tx_context::sender(ctx));
}

public fun access_defense(knight: &Knight): u64 {
    knight.armor.defense
}

public struct Sword has key, store {
    id: UID,
    damage: u64,
} // This sword object is owned because it is unique for each individual therefore can't be shared

/*examples of owned Object
                - NFT
                - Asset(crypto)
                - Profile data
                */
/*examples of shared Object
                - Marketplace
                - Launchpool
                - Staking protocol
                */
/*examples of immutable Object
                - Software Developer Kit(SDK)
                - Protocol Constants
                - Game Rules
                */

entry fun create_Sword(damage: u64, ctx: &mut TxContext) {
    let sword = Sword {
        id: object::new(ctx),
        damage,
    };
    transfer::public_transfer(sword, tx_context::sender(ctx));
}

public struct Shield has key, store {
    id: UID,
    defense: u64,
}

entry fun create_shield(defense: u64, ctx: &mut TxContext) {
    let shield = Shield {
        id: object::new(ctx),
        defense,
    };
    transfer::public_transfer(shield, tx_context::sender(ctx));
}

entry fun send_shield(shield: Shield, recipient: address) {
    transfer::public_transfer(shield, recipient);
}

public fun upgrade_defense(shield: &mut Shield) {
    shield.defense = shield.defense + 5;
}

public fun create_Vector() {
    let mut vector1: vector<u64> = vector[10, 20, 30];

    vector::pop_back(
        &mut vector1,
    );

    let first = vector::borrow(
        &vector1,
        0,
    );
    let value = vector::borrow_mut(
        &mut vector1,
        2,
    );

    *value = 45;
}

public struct Inventory has key, store {
    id: UID,
    list: vector<u64>,
}

public struct Bag has store {
    items: vector<u64>,
}

public struct Character has key, store {
    id: UID,
    bag: Bag,
}

public fun add_items(bag: &mut Bag, item: u64) {
    vector::push_back(
        &mut bag.items,
        item,
    );
}

public fun remove_items(bag: &mut Bag): u64 {
    vector::pop_back(
        &mut bag.items,
    )
}

public fun count_items(bag: &Bag): u64 {
    vector::length(
        &bag.items,
    )
}

#[test]
fun test_bag() {
    let mut bag = Bag {
        items: vector[],
    };
    add_items(&mut bag, 10);
    add_items(&mut bag, 20);
    add_items(&mut bag, 30);
    assert!(count_items(&bag) == 3, 0);
    remove_items(&mut bag);
    assert!(count_items(&bag) == 2, 0);

    let Bag { items: _remaining_items } = bag;
}

public struct GOLD has drop {
    Name: vector<u8>,
    Symbol: vector<u8>,
    Decimals: u64,
}

public struct Gol has key, store {
    id: UID,
    balance: Balance<GOLD>,
}

entry fun mint(token: &GOLD) {}
