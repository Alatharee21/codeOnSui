module hello_sui::guide{
    public struct Rank has store{
        title: vector<u8>,
        power_bonus: u64,
    }

    public struct GuildMember has key, store{
        id: UID,
        name: vector<u8>,
        level: u64,
        rank: Rank,
        total_power: u64,
    }

    entry fun create_member(
        title: vector<u8>,
        power_bonus: u64,
        name: vector<u8>,
        level: u64,
        total_power: u64,
        ctx: &mut TxContext
    ){
        let rank = Rank { title, power_bonus };

        let member = GuildMember{
            id: object::new(ctx),
            name,
            level,
            rank,
            total_power,
        };
        transfer::public_transfer(member, tx_context::sender(ctx));
    }

    public fun totall_power(member: &GuildMember): u64{
        member.level + member.rank.power_bonus
    }

    #[test]
    fun test_total_power(){
        let mut ctx = tx_context::dummy();
        let rank = Rank { 
            title: b"Knight", 
            power_bonus: 10 
        };

        let member = GuildMember {
            id: object::new(&mut ctx),
            name: b"Alice",
            level: 67,
            rank,
            total_power: 0, // Initial value
        };
        
       let calculated_power: u64 = totall_power( &member);

       assert!(calculated_power == 77, 0);

       let GuildMember { id, name: _, level: _, rank: Rank { title: _, power_bonus: _ }, total_power: _ } = member;
        
        object::delete(id);
    }
}