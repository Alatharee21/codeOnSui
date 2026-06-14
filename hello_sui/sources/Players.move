module hello_sui::Players{
    const E_NOT_OWNER: u64 = 1;

    public struct Player has key, store{
        id: UID,
        owner: address,
        level: u64,
    }

    //Public function

    public fun train(
        player: &mut Player,
        ctx: &TxContext
    ){
        verify_owner(player, ctx);
        increase_level(player);
    }

    //Helper funtions

    fun verify_owner(
        player: &Player,
        ctx: &TxContext
    ){
        let owner = tx_context::sender(ctx);

        assert!(
            player.owner == owner,
            E_NOT_OWNER
        )
    }

    fun increase_level(
        player: &mut Player
    ){
        player.level = player.level + 10;
    }
}