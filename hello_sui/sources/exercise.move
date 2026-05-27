
module hello_sui::calculator {
    public fun add(a: u64, b: u64): u64 {
        a + b
    }
    public fun subtract(a: u64, b: u64): u64 {
        a - b
    }
    public fun multiply(a: u64, b: u64): u64 {
        a * b
    }
    public fun divide(a: u64, b: u64): u64 {
        a / b
    }
    public fun max(a: u64, b: u64): u64 {
        if (a > b) {
            a
        } else {
            b
        }
    }
    public fun min(a: u64, b: u64): u64 {
        if (a < b) {
            a
        } else {
            b
        }
    }
    public fun is_even(a: u64): bool {
        a % 2 == 0
    }


#[test]

fun test_add(){
    let result = add(2, 3);
    assert!(result == 5, 0);
}

#[test]
fun test_add_2(){
    let result = add(2, 3);
    assert!(result == 7, 0);
}

#[test]
fun test_is_even(){
    assert!(is_even(7), 0);
}

#[test]
fun test_is_noteven(){
    assert!(!is_even(7), 0);
}

}

module hello_sui::bank{
    fun deposit(amount: u64): u64 {amount}
    fun withdraw(amount: u64): u64 {amount}
    fun calculate_fee(amount: u64): u64{
        let rate: u64 = 6/1000;
        amount * rate
    }
    public fun can_withdraw(amount: u64, balance: u64): bool{
        if(amount <= balance){
            true
        }else{
            false
        }
    }

    public fun calculate_bonus(balance: u64): u64{
        if(balance >= 1000000){
            let bonus: u64 = 5/100;
            balance * bonus
        }else{
            0
        }
    }

    public fun get_account_level(balance: u64): u64{
        if(balance >= 5000000){
            1
        }else if(balance >= 350000 && balance < 5000000){
            2
        }else{
            3
        }
    }

    #[test]
    fun test_deposit(){
        let amount: u64 = 1000;
        let result = deposit(amount);
        assert!(result == 1000, 0);
    }

    #[test]
    fun test_can_withdraw(){
        let amount: u64 = 2000;
        let balance: u64 = 1067;
        assert!(can_withdraw(amount, balance), 0);
    }
}

module hello_sui::vault{
    use std::unit_test::assert_eq;
    use std::u64;

    fun calculate_interest(balance: u64): u64{
        balance * 3/1000
    }

    public fun preview_interest(balance: u64): u64{
        calculate_interest(balance)
    }

    entry fun claim_rewards(balance: u64): u64{
        let reward: u64 = calculate_interest(balance);  
        reward
    }

        #[test]
        fun test_calculate_interest(){
            let balance: u64 = 1000000;
            let result = calculate_interest(balance);
            assert!(result == 3000, 0);
        }

        #[test]
        fun test_claim_rewards(){
            let balance: u64 = 1000000;
            let result = claim_rewards(balance);
            assert_eq!(result, 3000);
        }
}

module hello_sui::pet{
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;

    public struct Pet has key, store{
        id: UID,
        name: vector<u8>,
        level: u64,
        health: u64,
    }

    entry fun create_Pet(
        name: vector<u8>,
        level: u64,
        health: u64,
        ctx: &mut TxContext
    ){
        let pet = Pet{
            id: object::new(ctx),
            name,
            level,
            health,
        };
        transfer::public_transfer(pet, tx_context::sender(ctx));
    }

    public fun preview_power(level: u64, health: u64): u64{
        level * health
    }

    #[test]
    fun test_create_Pet(){
        let name: vector<u8> = b"Fluffy";
        let level: u64 = 5;
        let health: u64 = 100;
        // Create a pet and assert its properties
        assert!(name == b"Fluffy", 0);
        assert!(level == 5, 0);
        assert!(health == 100, 0);

        let power = preview_power(level, health);
        assert!(power == 500, 0);
    }
}

module hello_sui::warrior{
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;
    use std::u64;

    public struct Weapon has store{
        damage: u64,
    }

    public struct Warrior has key, store{
        id: UID,
        health: u64,
        weapon: Weapon,
    }

    entry fun create_Warrior(
        health: u64,
        damage: u64,
        ctx: &mut TxContext
    ){
        let weapon = Weapon{
            damage,
        };
        

        let warrior = Warrior{
            id: object::new(ctx),
            health,
            weapon,
        };

        transfer::public_transfer(warrior, tx_context::sender(ctx));

    }

    public fun get_weapon(warrior: &Warrior): u64{
        warrior.weapon.damage
    }

    public fun train(warrior: &mut Warrior){
        warrior.health = warrior.health + 3
    }

    #[test]
    fun test_create_Warrior(){
        let mut _ctx = sui::tx_context::dummy();
        let health: u64 = 100;
        let damage: u64= 25;

        assert!(health == 100, 0);
        assert!(damage == 25, 0);
    }
}

module hello_sui::ticket{
    public struct Ticket has key, store{
        id: UID,
        event_name: vector<u8>,
        seat_number: u64,
    }

    entry fun create_ticket(
        event_name: vector<u8>,
        seat_number: u64,
        ctx: &mut TxContext
    ){
        let ticket = Ticket{
        id: object::new(ctx),
        event_name,
        seat_number,
        };
        
        transfer::public_transfer(ticket, tx_context::sender(ctx));
    }

    entry fun send_ticket(ticket: Ticket, recipient: address){
        transfer::public_transfer(ticket, recipient);
    }

    public fun get_seat(ticket: &Ticket): u64{
        ticket.seat_number
    }
}

module hello_sui::bag{
    use std::vector;

    public struct Bag has key, store{
        id: UID,
        items: vector<u64>,
    }

    entry fun add_item(
        bag: &mut Bag,
        item: u64
    ){
        vector::push_back(
            &mut bag.items,
            item
        )
    }

    entry fun remove_item(
        bag: &mut Bag
    ): u64{
        vector::pop_back(
            &mut bag.items
        )
    }

    entry fun count_item(bag: &Bag): u64{
        vector::length(
            &bag.items
        )
    }
}

module hello_sui::party{
    use std::vector;
    use sui::object::{Self, UID};

    public struct Party has key, store{
        id: UID,
        members: vector<vector<u8>>,
    }

    entry fun add_member(party: &mut Party, member: vector<u8>){
        vector::push_back(
            &mut party.members,
            member
        );
    }

    entry fun remove_member(party: &mut Party): vector<u8>{
        vector::pop_back(
            &mut party.members
        )
    }

    public fun count_member(party: &Party): u64{
        vector::length(
            &party.members
        )
    }

    public fun get_first_member(party: &Party): &vector<u8>{
        vector::borrow(
            &party.members,
            0
        )
    }

    public fun theLoop(party: &mut Party){
        let mut i = 0;
        while (i < vector::length(&party.members)){
            let item = vector::borrow(
                &mut party.members,
                i
            );
            i = i + 1;
        }
    }
}