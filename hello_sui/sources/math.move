module hello_sui::math{
    fun addy(a: u64, b: u64): u64 {
        let c: u8 = 10; //statement ends with semicolon
        let score = 100;
        let d: u64 = 5;
        let numbers: vector<u64> = vector[1, 2, 3];// array dynamic size, vector is a struct in Move
        a + b - d //last statement in a function is the return value, no semicolon
    }

    fun get_level(): u64  {
        let owner: address =  @0x1;
        let admin: bool;
        let amount: u64;

        amount = 1500;
        amount
    }
    
}