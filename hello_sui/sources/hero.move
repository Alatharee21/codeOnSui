module hello_sui::hero {
   
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;

    public struct Hero has key, store {
        id: UID,
        power: u64,
    }

    public entry fun create_hero(
        power: u64,
        ctx: &mut TxContext
    ) {
        let hero = Hero {
            id: object::new(ctx),
            power,
        };
        transfer::public_transfer(hero, tx_context::sender(ctx));
            }
}