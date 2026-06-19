#[allow(lint(self_transfer), duplicate_alias)]

module staking_protocol::staking_protocol;

use sui::event;
use sui::object::{Self, UID};
use sui::transfer;
use sui::tx_context::{Self, TxContext};

//Errors
const ER_NOT_REAL_OWNER: u64 = 1;

//Objects
public struct Pool has key {
    id: UID,
    totalStakedAmount: u64,
    rewardRate: u64,
    numberOfStakers: u64,
    protocolstatus: bool,
}

public struct UserStakePosition has key, store {
    id: UID,
    owner: address,
    stakedAmount: u64,
    pendingRewards: u64,
}
public struct UserStakePosition_event has copy, drop {
    owner: address,
    stakedAmount: u64,
    pendingRewards: u64,
}

public struct RewardPool has key, store {
    id: UID,
    rewardTokenBalance: u64,
    totalRewardsDistributed: u64,
    remainingRewards: u64,
}

public struct ProtocolConfig has key, store {
    id: UID,
    minimumStakeAmount: u64,
    maximumStakeAmount: u64,
    lockPeriod: u64,
    feeRate: u64,
    rewardEmissionRate: u64,
}

//Capability
public struct AdminCap has key, store {
    id: UID,
}

//Public Function

public fun pool_int(
    totalStakedAmount: u64,
    rewardRate: u64,
    numberOfStakers: u64,
    protocolstatus: bool,
    ctx: &mut TxContext,
) {
    let pool = Pool {
        id: object::new(ctx),
        totalStakedAmount,
        rewardRate,
        numberOfStakers,
        protocolstatus,
    };
    transfer::share_object(pool);
}

public fun reward_pool(
    rewardTokenBalance: u64,
    totalRewardsDistributed: u64,
    remainingRewards: u64,
    ctx: &mut TxContext,
) {
    let rewardPool = RewardPool {
        id: object::new(ctx),
        rewardTokenBalance,
        totalRewardsDistributed,
        remainingRewards,
    };
    transfer::share_object(rewardPool);
}

public fun stake(
    userStake: &mut UserStakePosition,
    rewardPool: &mut RewardPool,
    pool: &mut Pool,
    amount: u64,
    ctx: &mut TxContext,
) {
    userStake.owner = tx_context::sender(ctx);
    let distributed_rewards = calculate_reward(pool, userStake, rewardPool, amount);
    userStake.stakedAmount = userStake.stakedAmount + amount;
    userStake.pendingRewards = userStake.pendingRewards - distributed_rewards;
    pool.totalStakedAmount = pool.totalStakedAmount + amount;
    pool.numberOfStakers = pool.numberOfStakers + 1;
    rewardPool.totalRewardsDistributed = rewardPool.totalRewardsDistributed + distributed_rewards;
    rewardPool.remainingRewards = rewardPool.remainingRewards - distributed_rewards;
    rewardPool.rewardTokenBalance = rewardPool.rewardTokenBalance - distributed_rewards;
    stake_event(userStake.owner, userStake.stakedAmount, userStake.pendingRewards);
}

public fun unStake(
    userStake: &mut UserStakePosition,
    pool: &mut Pool,
    amount: u64,
    ctx: &mut TxContext,
) {
    assert!(userStake.owner == tx_context::sender(ctx), ER_NOT_REAL_OWNER);

    userStake.stakedAmount = userStake.stakedAmount - amount;
    pool.totalStakedAmount = pool.totalStakedAmount - amount;
    pool.numberOfStakers = pool.numberOfStakers - 1;
    stake_event(userStake.owner, userStake.stakedAmount, userStake.pendingRewards);
}

public fun my_reward(
    pool: &Pool,
    userStake: &UserStakePosition,
    rewardPool: &RewardPool,
    stake_amount: u64,
): u64 {
    calculate_reward(pool, userStake, rewardPool, stake_amount)
}

public fun transfer_admin_cap(admin: AdminCap, recipient: address) {
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
    pool: &Pool,
    userStake: &UserStakePosition,
    rewardPool: &RewardPool,
    stake_amount: u64,
): u64 {
    let base_reward = pool.rewardRate * userStake.stakedAmount;
    let emission_bonus = rewardPool.rewardTokenBalance / 100;
    let reward = base_reward + emission_bonus + stake_amount;
    if (reward > rewardPool.remainingRewards) {
        rewardPool.remainingRewards
    } else {
        reward
    }
}

public fun config_protocol(
    _admin: &AdminCap,
    minimumStakeAmount: u64,
    maximumStakeAmount: u64,
    lockPeriod: u64,
    feeRate: u64,
    rewardEmissionRate: u64,
    ctx: &mut TxContext,
) {
    let protocol_config = ProtocolConfig {
        id: object::new(ctx),
        minimumStakeAmount,
        maximumStakeAmount,
        lockPeriod,
        feeRate,
        rewardEmissionRate,
    };
    transfer::public_transfer(protocol_config, tx_context::sender(ctx));
}

public fun stake_event(owner: address, stakedAmount: u64, pendingRewards: u64) {
    event::emit(UserStakePosition_event {
        owner,
        stakedAmount,
        pendingRewards,
    });
}
