module staking_protocol::staking_protocol{
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;

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
        
        public struct ProtocolConfig has key, store{
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

    public fun config_protocol(
            _admin: &AdminCap,
            minimumStakeAmount: u64,
            maximumStakeAmount: u64,
            lockPeriod: u64,
            feeRate: u64,
            rewardEmissionRate: u64,
            ctx: &mut TxContext
    ){
        let protocol_config = ProtocolConfig {
            id: object::new(ctx),
            minimumStakeAmount,
            maximumStakeAmount,
            lockPeriod,
            feeRate,
            rewardEmissionRate,
        };
        transfer::freeze_object(protocol_config);
    }
    }