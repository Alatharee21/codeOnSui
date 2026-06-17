module hello_sui::community{
    use sui::transfer;

    public struct Community has key{
        id: UID,
        members: u64,
        posts: u64,
    }

    //Frontend function
    entry fun join(
        community: &mut Community
    ){
        community.members = community.members + 1
    }

    entry fun create_post(
        community: &mut Community
    ){
        community.posts = community.posts + 1
    }

    //Helper function
    fun init(
        ctx: &mut TxContext
    ){
        let community = Community{
            id: object::new(ctx),
            members: 0,
            posts: 0
        };

        transfer::share_object(community);
    }
}