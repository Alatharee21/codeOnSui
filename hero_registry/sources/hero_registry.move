module hero_registry::hero_registry{
    /*
    Users can:
    - Create heroes
    - View hero stats
    - Calculate hero power
    - Test hero logic
    */
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;

    public struct Hero has key, store{
        id: UID,
        name: vector<u8>,
        heart: u64,
        age: u64,
        kills: u64,
        power: u64,
    }

    entry fun create_hero(
        name: vector<u8>,
        heart: u64,
        age: u64,
        kills: u64,
        power: u64,
        ctx: &mut TxContext
    ){
        let hero = Hero {
            id: object::new(ctx),
            name,
            heart,
            age,
            kills,
            power,
        };
        transfer::public_transfer(hero, tx_context::sender(ctx));
        }

        public fun get_Hero_heart(hero: &Hero): u64{
            hero.heart
        }
        public fun get_Hero_age(hero: &Hero): u64{
            hero.age
        }
        public fun get_Hero_kills(hero: &Hero): u64{
            hero.kills
        }
        public fun calculate_power(hero: &mut Hero): u64{
            let power: u64 = (hero.heart * hero.kills)/hero.age;
            hero.power = power;
            power
        }
        public fun get_Hero_power(hero: &Hero): u64{
            hero.power
        }
        public fun is_Alive(hero: &Hero): bool{
            if(hero.heart > 0){
                true
            } else {
                false
            }
        }
    }