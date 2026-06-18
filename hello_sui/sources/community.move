module hello_sui::community{
    use sui::transfer;

    public struct Community has key{
        id: UID,
        members: u64,
        last_post: vector<u8>,
        posts: u64,
    }

    //Frontend function
    entry fun join(
        community: &mut Community
    ){
        community.members = community.members + 1
    }

    entry fun create_post(
        community: &mut Community,
        text: vector<u8>
    ){
        community.posts = community.posts + 1;
        community.last_post = text
    }

    //Helper function
    fun init(
        ctx: &mut TxContext
    ){
        let community = Community{
            id: object::new(ctx),
            members: 0,
            last_post: vector[],
            posts: 0
        };

        transfer::share_object(community);
    }
}