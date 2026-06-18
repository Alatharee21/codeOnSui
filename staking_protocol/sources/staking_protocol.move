module staking_protocol::staking_protocol{

    public struct Pool has key{
        id: UID,
        totalStakedAmount: u64,
        rewardRate: u64,
        rewardPoolBalance: u64,
        numberOfStakers: u64,
        protocolstatus: bool,
    }

    public struct UserStakePosition has key, store{
        id: UID,
        owner: address,
        stakedAmount: u64,
        pendingRewards: u64,
    }

    public struct RewardPool has key{
        id: UID,
        rewardTokenBalance: u64,
        totalRewardsDistributed: u64,
        remainingRewards: u64,
        }
        
        public struct ProtocolConfig has key{
            id: UID,
            minimumStakeAmount: u64,
            maximumStakeAmount: u64,
            lockPeriod: u64,
            feeRate: u64,
            rewardEmissionRate: u64,
        }

        public struct AdminCap has key, store{
        id: UID,
        }

        //Public Function
        public fun stake(
            userStake: &mut UserStakePosition,
            pool: &mut Pool,
            amount: u64,
            ctx: &mut TxContext
        ){
            userStake.owner = tx_context::sender(ctx);
            userStake.stakedAmount = userStake.stakedAmount + amount;
            pool.totalStakedAmount = pool.totalStakedAmount + amount;
            pool.numberOfStakers = pool.numberOfStakers + 1;
        }

        public fun unStake(
            userStake: &mut UserStakePosition,
            pool: &mut Pool,
            amount: u64,
            ctx: &mut TxContext
        ){
            userStake.owner = tx_context::sender(ctx);
            userStake.stakedAmount = userStake.stakedAmount - amount;
            pool.totalStakedAmount = pool.totalStakedAmount - amount;
            pool.numberOfStakers = pool.numberOfStakers - 1;
        }

        public fun my_reward(
            pool: &mut Pool,
            userStake: &UserStakePosition 
        ){
            calculate_reward(pool, userStake)
        }

    public fun transfer_admin_cap(
        _admin: &AdminCap,
        admin: AdminCap,
        recipient: address
    ) {
        transfer::public_transfer(admin, recipient);
    }

    public fun pause_pool(pool: &mut Pool, _admin: &AdminCap) {
        pool.protocolstatus = false;
    }

    public fun resume_pool(pool: &mut Pool, _admin: &AdminCap) {
        pool.protocolstatus = true;
    }

    //Helper function
    fun calculate_reward(
        pool: &mut Pool,
        userStake: &UserStakePosition
    ) {
        pool.rewardRate = pool.rewardRate * userStake.stakedAmount
    }
    }