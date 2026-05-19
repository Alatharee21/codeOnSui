/*
/// Module: hello_world*/

module hello_world::hello_world{
    use std::string::{Self, String};
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    struct HelloWorldObject has key {
        id: UID,
        text: String
    }
    public entry fun mint(ctx: &mut TxContext) {
        let object : HelloWorldObject= HelloWorldObject {
            id: UID: object::new(ctx),
            text: String: string::utf8(bytes: b"Hello, World!")
        };
        transfer::transfer(obj: object, recipient:tx_context::sender(self:ctx));
    }
}


// For Move coding conventions, see
// https://docs.sui.io/concepts/sui-move-concepts/conventions

