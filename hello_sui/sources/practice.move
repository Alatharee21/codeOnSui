module hello_sui::practice{
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;

    fun divide(a: u64, b: u64): u64{
        a/b
    }
    fun is_even(num: u64): bool{
        num % 2 == 0
    }
    fun max(a: u64, b: u64): u64{
        if(a > b){
            25
        }else{
            26
        }
    }
    fun min(a: u64, b: u64): u64{
        if(a < b){
            25
        }else{
            26
        }
    }
    public fun createVariables(): u64{
        let score: u64 = 45;
        let mana: u64 = 35;
        let stamina: u64 = 25;

        score + mana + stamina
    }

    public fun can_buy(balance: u64, price: u64, quantity: u64): bool{
        if(balance >= price){
            let jara: u64 = 5;
            quantity + jara;
            true
        }else{
            false
        }
    }

    public fun reward(score: u64): u64{
        if(score == 5){
            if(score >= 50){
                1 //Gold reward
            }else{
                2 //Silver reward
            }
        }else{
            3 //Bronze reward
        }
    }

    fun square(num: u64): u64{
        num*num
    }

    public fun preview_square(num: u64): u64{
        square(num)
    }

    entry fun compute(num: u64){
        let result: u64 = square(num);
    }

    public struct Monster has key, store{
        id: UID,
        strength: u64,
    } 

    entry fun create_Monster(
        strength: u64,
        ctx: &mut TxContext,
    ){
        let monster = Monster {
            id: object::new(ctx),
            strength,
            };
            transfer::public_transfer(monster, tx_context::sender(ctx));
            }
    }