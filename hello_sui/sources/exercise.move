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