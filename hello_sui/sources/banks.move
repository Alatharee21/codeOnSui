module hello_sui::banks{
    //This function cannot be directly called by users because it is private.
    fun calculate_fee(amount: u64): u64{
        amount/10
    }
    //This function can be accessed by other modules because it is public
    public fun preview_fee(amount: u64): u64{
        calculate_fee(amount)//can be used because they are same module
    }
    //Users can interact with this function
    entry fun deposit(amount: u64){
        calculate_fee(amount);
    }
}