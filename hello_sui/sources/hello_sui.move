/// Module: hello_sui
module hello_sui::hello{
    use std::vector;
    //u8,u16,u32,u64,u128,u256
    /*let explicit_u8 = 1u8;
    let explicit_u64_underscored = 154_322_973u64;

    let simple_u8: u8 = 1;*/
    //i8,i16,i32,i64,i128,i256
    //bool
    //address
    //vector
    //struct

    public fun check_vec(): vector<u8>{
    let mut numbers: vector<u8> = vector[];//Has to have mut to be mutable
    let check: vector<bool> = vector[true, false];

    //These push these figures into numbers
    vector::push_back(&mut numbers, 100);
    vector::push_back(&mut numbers, 200);
    vector::push_back(&mut numbers, 210);
    vector::push_back(&mut numbers, 230);

    //This removes the last figure(230)
    vector::pop_back(&mut numbers);

    let gradeA = vector::borrow(
        &numbers,
        1
    );// This borrows [200]
    let gradeB = vector::borrow_mut(
        &mut numbers,
        0
    );
    *gradeB = 123;// this turns [100] to [123]

    vector::length(&numbers);

    numbers
    }
    //Private function not accessible outside of this module
    fun add(a: u64, b: u64): u64 {
        a + b
    }
    public fun sub(c: u64, d: u64): u64 {
        c - d
    }

    //Public function accessible outside of this module
    public fun mul(e: u64, f: u64): u64 {
        e * f
    }

    public fun calc_interest(
        balance: u64,
        rate: u64
    ): u64 {
        (balance * rate) / 100
    }

    //Entry point function that can be called from outside the module
    entry fun hello_sui(): vector<u8> {
        let _sum = add(2, 3);
        let _difference = sub(5, 2);
        let _product = mul(4, 6);
        let _interest = calc_interest(1000, 5);
        // Return a greeting message as a byte vector
        b"Hello, Sui!"
    }
}


// For Move coding conventions, see
// https://docs.sui.io/concepts/sui-move-concepts/conventions

