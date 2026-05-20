module hello_sui::game {
    public fun get_health(): u64 {
        let health: u64; // Health
        let mana: u64; // Mana
        let is_alive: bool; //Alive Status

        100
    }

    public fun is_alive(health: u64): bool{
        if(health > 0){
            true
        }else{
            false
        }
    }

    public fun get_rank(score: u64): u64{
        if(score >= 1000){
            1
        }else{
            2
        }
    }
}