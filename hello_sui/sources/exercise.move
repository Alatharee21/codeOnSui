/*module exercise::exercise {
    public fun divide(a: u64, b: u64): u64{}
    public fun is_positive(num: u64): bool{}
    public fun min(a: u64, b: u64): u64{}
    public fun is_multiple_of_5(num: u64): bool{}
    public fun calculate_reward(stake: u64, percent: u64): u64{}
    public fun can_withdraw(balance: u64, amount: u64): bool{}
}*/
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
}

module hello_sui::bank{
    fun deposit(amount: u64): u64 {amount}
    fun withdraw(amount: u64): u64 {amount}
    fun calculate_fee(amount: u64): u64{
        let rate: u64 = 6/1000;
        amount * rate
    }
    public fun can_withdraw(amount: u64): bool{
        if(amount <= deposit(amount)){
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
}

module hello_sui::vault{
    fun calculate_interest(balance: u64): u64{
        balance * 3/1000
    }

    public fun preview_interest(balance: u64): u64{
        calculate_interest(balance)
    }

    entry fun claim_rewards(balance: u64){
        let reward: u64 = calculate_interest(balance);  
        }
}