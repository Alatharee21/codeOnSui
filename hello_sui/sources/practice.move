module hello_sui::practice{
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
}