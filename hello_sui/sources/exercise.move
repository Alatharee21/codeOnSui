module hello_sui::calculator {
    public fun calculations(a: u64, b: u64) {
        add(a, b);
        subtract(a, b);
        multiply(a, b);
        divide(a, b);
        max(a, b);
        min(a, b);
        is_even(a);
    }

    fun add(a: u64, b: u64): u64 {
        a + b
    }

    fun subtract(a: u64, b: u64): u64 {
        a - b
    }

    fun multiply(a: u64, b: u64): u64 {
        a * b
    }

    fun divide(a: u64, b: u64): u64 {
        a / b
    }

    fun max(a: u64, b: u64): u64 {
        if (a > b) {
            a
        } else {
            b
        }
    }

    fun min(a: u64, b: u64): u64 {
        if (a < b) {
            a
        } else {
            b
        }
    }

    fun is_even(a: u64): bool {
        a % 2 == 0
    }

    #[test]

    fun test_add() {
        let a: u64 = 3;
        let b: u64 = 2;
        let addition = add(2, 3);
        let substraction = subtract(a, b);
        let multiplication = multiply(a, b);
        let division = divide(a, b);
        let maximum = max(a, b);
        let minimum = min(a, b);

        assert!(addition == 5, 0);
        assert!(substraction == 1, 0);
        assert!(multiplication == 6, 0);
        assert!(division == 5, 0);
        assert!(maximum == 5, 0);
        assert!(minimum == 5, 0);
        assert!(is_even(addition), 0);
    }
}

module hello_sui::bank {
    fun deposit(amount: u64): u64 { amount }

    entry fun withdraw(amount: u64): u64 { amount }

    entry fun calculate_fee(amount: u64): u64 {
        let rate: u64 = 6/1000;
        amount * rate
    }

    public fun can_withdraw(amount: u64, balance: u64): bool {
        if (amount <= balance) {
            true
        } else {
            false
        }
    }

    public fun calculate_bonus(balance: u64): u64 {
        if (balance >= 1000000) {
            let bonus: u64 = 5/100;
            balance * bonus
        } else {
            0
        }
    }

    public fun get_account_level(balance: u64): u64 {
        if (balance >= 5000000) {
            1
        } else if (balance >= 350000 && balance < 5000000) {
            2
        } else {
            3
        }
    }

    #[test]
    fun test_deposit() {
        let amount: u64 = 1000;
        let result = deposit(amount);
        assert!(result == 1000, 0);
    }

    #[test]
    #[expected_failure(abort_code = 0)]
    fun test_can_withdraw() {
        let amount: u64 = 2000;
        let balance: u64 = 1067;
        assert!(can_withdraw(amount, balance), 0);
    }
}

module hello_sui::vault {
    use std::u64;
    use std::unit_test::assert_eq;

    fun calculate_interest(balance: u64): u64 {
        balance * 3/1000
    }

    public fun preview_interest(balance: u64): u64 {
        calculate_interest(balance)
    }

    entry fun claim_rewards(balance: u64): u64 {
        let reward: u64 = calculate_interest(balance);
        reward
    }

    #[test]
    fun test_calculate_interest() {
        let balance: u64 = 1000000;
        let result = calculate_interest(balance);
        assert!(result == 3000, 0);
    }

    #[test]
    fun test_claim_rewards() {
        let balance: u64 = 1000000;
        let result = claim_rewards(balance);
        assert_eq!(result, 3000);
    }
}

module hello_sui::pet {
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    public struct Pet has key, store {
        id: UID,
        name: vector<u8>,
        level: u64,
        health: u64,
    }

    entry fun create_Pet(name: vector<u8>, level: u64, health: u64, ctx: &mut TxContext) {
        let pet = Pet {
            id: object::new(ctx),
            name,
            level,
            health,
        };
        transfer::public_transfer(pet, tx_context::sender(ctx));
    }

    public fun preview_power(level: u64, health: u64): u64 {
        level * health
    }

    #[test]
    fun test_create_Pet() {
        let name: vector<u8> = b"Fluffy";
        let level: u64 = 5;
        let health: u64 = 100;
        // Create a pet and assert its properties
        assert!(name == b"Fluffy", 0);
        assert!(level == 5, 0);
        assert!(health == 100, 0);

        let power = preview_power(level, health);
        assert!(power == 500, 0);
    }
}

module hello_sui::warrior {
    use std::u64;
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    public struct Weapon has store {
        damage: u64,
    }

    public struct Warrior has key, store {
        id: UID,
        health: u64,
        weapon: Weapon,
    }

    entry fun create_Warrior(health: u64, damage: u64, ctx: &mut TxContext) {
        let weapon = Weapon {
            damage,
        };

        let warrior = Warrior {
            id: object::new(ctx),
            health,
            weapon,
        };

        transfer::public_transfer(warrior, tx_context::sender(ctx));
    }

    public fun get_weapon(warrior: &Warrior): u64 {
        warrior.weapon.damage
    }

    public fun train(warrior: &mut Warrior) {
        warrior.health = warrior.health + 3
    }

    #[test]
    fun test_create_Warrior() {
        let mut _ctx = sui::tx_context::dummy();
        let health: u64 = 100;
        let damage: u64 = 25;

        assert!(health == 100, 0);
        assert!(damage == 25, 0);
    }
}

module hello_sui::ticket {
    public struct Ticket has key, store {
        id: UID,
        event_name: vector<u8>,
        seat_number: u64,
    }

    entry fun create_ticket(event_name: vector<u8>, seat_number: u64, ctx: &mut TxContext) {
        let ticket = Ticket {
            id: object::new(ctx),
            event_name,
            seat_number,
        };

        transfer::public_transfer(ticket, tx_context::sender(ctx));
    }

    entry fun send_ticket(ticket: Ticket, recipient: address) {
        transfer::public_transfer(ticket, recipient);
    }

    public fun get_seat(ticket: &Ticket): u64 {
        ticket.seat_number
    }
}

module hello_sui::bag {
    use std::vector;

    public struct Bag has key, store {
        id: UID,
        items: vector<u64>,
    }

    entry fun add_item(bag: &mut Bag, item: u64) {
        vector::push_back(
            &mut bag.items,
            item,
        )
    }

    entry fun remove_item(bag: &mut Bag): u64 {
        vector::pop_back(
            &mut bag.items,
        )
    }

    entry fun count_item(bag: &Bag): u64 {
        vector::length(
            &bag.items,
        )
    }
}

#[allow(unused_variable)]
module hello_sui::party {
    use std::vector;
    use sui::object::{Self, UID};

    public struct Party has key, store {
        id: UID,
        members: vector<vector<u8>>,
    }

    entry fun add_member(party: &mut Party, member: vector<u8>) {
        vector::push_back(
            &mut party.members,
            member,
        );
    }

    entry fun remove_member(party: &mut Party): vector<u8> {
        vector::pop_back(
            &mut party.members,
        )
    }

    public fun count_member(party: &Party): u64 {
        vector::length(
            &party.members,
        )
    }

    public fun get_first_member(party: &Party): &vector<u8> {
        vector::borrow(
            &party.members,
            0,
        )
    }

    public fun theLoop(party: &mut Party) {
        let mut i = 0;
        while (i < vector::length(&party.members)) {
            let item = vector::borrow(
                &mut party.members,
                i,
            );
            i = i + 1;
        }
    }
}

#[allow(unused_variable)]
module hello_sui::guild {
    use std::vector;

    public struct Member has store {
        power: u64,
    }
    public struct GuildStorage has store {
        members: vector<Member>,
    }
    public struct Guild has key, store {
        id: UID,
        storage: GuildStorage,
    }

    entry fun add_member(storage: &mut GuildStorage, member: Member) {
        vector::push_back(
            &mut storage.members,
            member,
        );
    }

    entry fun remove_member(storage: &mut GuildStorage): Member {
        vector::pop_back(
            &mut storage.members,
        )
    }

    entry fun total_member(storage: &mut GuildStorage): u64 {
        vector::length(
            &storage.members,
        )
    }

    public fun ncheck(storage: &mut GuildStorage) {
        let mut i = 0;
        let lent = vector::length(&storage.members);
        while (i < lent) {
            let value = vector::borrow(
                &storage.members,
                i,
            );
            i = i + 1;
        }
    }
}

module hello_sui::wallet_registry {
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    public struct WalletProfile has key, store {
        id: UID,
        owner: address,
        points: u64,
    }

    entry fun register(ctx: &mut TxContext) {
        let owner = tx_context::sender(ctx);
        let points = 0;

        let walletProfile = WalletProfile {
            id: object::new(ctx),
            owner,
            points,
        };
        transfer::freeze_object(walletProfile);
    }
}

module hello_sui::achievement {
    use sui::event;
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    public struct Achievement has key, store {
        id: UID,
        owner: address,
        points: u64,
    }

    public struct AchievementUnlocked has copy, drop {
        owner: address,
        points: u64,
    }

    entry fun unlock(ctx: &mut TxContext) {
        let owner = tx_context::sender(ctx);
        let points = 0;

        let achievement = Achievement {
            id: object::new(ctx),
            owner,
            points,
        };
        transfer::freeze_object(achievement);

        event::emit(AchievementUnlocked {
            owner,
            points,
        });
    }
}

module hello_sui::gayme {
    use std::unit_test;
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};

    const E_NOT_OWNER: u64 = 1;

    public struct Character has key, store {
        id: UID,
        owner: address,
        level: u64,
    }

    entry fun train(character: &mut Character, sender: address) {
        assert!(character.owner == sender, E_NOT_OWNER)
    }
}

module hello_sui::academic {
    use sui::event;

    const E_NOT_THE_OWNER: u64 = 1;

    //Object
    public struct Student has key, store {
        id: UID,
        owner: address,
        score: u64,
    }

    //Event
    public struct StudentTrained has copy, drop {
        owner: address,
        score: u64,
    }

    //Public Function
    public fun train_student(student: &mut Student, ctx: &TxContext) {
        verify_owner(student, ctx);
        increase_score(student);
        let owner = tx_context::sender(ctx);
        emit_training_event(owner, student.score);
    }

    //Helper Functions
    fun verify_owner(student: &Student, ctx: &TxContext) {
        let owner = tx_context::sender(ctx);
        assert!(student.owner == owner, E_NOT_THE_OWNER);
    }

    fun increase_score(student: &mut Student) {
        student.score = student.score + 3;
    }

    fun emit_training_event(owner: address, score: u64) {
        event::emit(StudentTrained {
            owner,
            score,
        });
    }
}

module hello_sui::aca {
    public struct TeacherCap has key, store {
        id: UID,
    }

    public struct School has key, store {
        id: UID,
        students: u64,
    }

    public fun admit_student(_cap: &TeacherCap, school: &mut School) {
        school.students = school.students + 1
    }
}

module hello_sui::exercise3_6 {
    public struct Leaderboard has key {
        id: UID,
        score: u64,
    }

    public fun increase_score(leaderboard: &mut Leaderboard, points: u64) {
        leaderboard.score = leaderboard.score + points
    }

    fun init(ctx: &mut TxContext) {
        let leaderboard = Leaderboard {
            id: object::new(ctx),
            score: 0,
        };
        transfer::share_object(leaderboard);
    }
}

module hello_sui::nft_exp {
    use std::string;
    use sui::event;
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    use sui::url::{Self, Url};

    public struct NftExample has key, store {
        id: UID,
        name: string::String,
        description: string::String,
        url: Url,
    }
    public struct NftExampleEvent has copy, drop {
        name: string::String,
        creator: address,
    }

    public fun get_nft_name(nft: &NftExample): std::string::String {
        nft.name
    }

    public fun get_nft_description(nft: &NftExample): std::string::String {
        nft.description
    }

    public fun get_nft_url(nft: &NftExample): Url {
        nft.url
    }

    entry fun create_new_nft(
        name: vector<u8>,
        description: vector<u8>,
        url: vector<u8>,
        ctx: &mut TxContext,
    ) {
        let sender = tx_context::sender(ctx);
        let new_nft = NftExample {
            id: object::new(ctx),
            name: string::utf8(name),
            description: string::utf8(description),
            url: url::new_unsafe_from_bytes(url),
        };

        event::emit(NftExampleEvent {
            name: new_nft.name,
            creator: sender,
        });

        transfer::public_transfer(new_nft, sender);
    }
}

module hello_sui::game_currency {
    use sui::coin::{Self, TreasuryCap};

    public struct CRYSTAL has drop {}

    entry fun mint_crystal(
        treasury_cap: &mut TreasuryCap<CRYSTAL>,
        amount: u64,
        winner: address,
        ctx: &mut TxContext,
    ) {
        let new_crystal = coin::mint(treasury_cap, amount, ctx);
        transfer::public_transfer(new_crystal, winner);
    }
}

module hello_sui::shop {
    use sui::balance::{Self, Balance};
    use sui::coin::{Self, Coin};
    use sui::event;
    use sui::transfer;

    public struct GEM has drop {}

    public struct Shop has key, store {
        id: UID,
        sales: u64,
    }

    public struct Merchant has key, store {
        id: UID,
        balance: Balance<GEM>,
        wallet: address,
    }

    public struct Shopped_event has copy, drop {
        payer: address,
        merchant: address,
        amount: u64,
    }

    public fun buy_item(
        ctx: &mut TxContext,
        shop: &mut Shop,
        coin: Coin<GEM>,
        merchant: &mut Merchant,
    ) {
        let payee = tx_context::sender(ctx);
        let amount = coin::value(&coin);
        increase_balance(merchant, coin);
        record_sales(shop);
        bought_event(payee, merchant.wallet, amount);
    }

    //pFun
    fun record_sales(shop: &mut Shop) {
        shop.sales = shop.sales + 1;
    }

    fun increase_balance(merchant: &mut Merchant, coin: Coin<GEM>) {
        let new_balance = coin::into_balance(coin);
        balance::join(&mut merchant.balance, new_balance);
    }

    fun bought_event(payer: address, merchant: address, amount: u64) {
        event::emit(Shopped_event {
            payer,
            merchant,
            amount,
        })
    }
}

module hello_sui::marketplace {
    public struct THECOIN has drop {}

    public struct Merchant {}
    public struct Treasury {}
    public struct PurchaseMade {}

    public fun purchase() {}
}

module hello_sui::students_cert {
    use std::string::String;
    use sui::event;
    use sui::transfer;

    public struct StudentCertificate has key, store {
        id: UID,
        //MetaData
        student_name: String,
        course: String,
        grade: String,
    }
    public struct StudentCertified has copy, drop {
        student_name: String,
        course: String,
        grade: String,
    }

    public struct Principal has key {
        id: UID,
    }

    public fun issue_cert(
        _principal: &Principal,
        student_name: String,
        course: String,
        grade: String,
        ctx: &mut TxContext,
    ) {
        certificate(student_name, course, grade, ctx);
        certfified(student_name, course, grade);
    }

    fun certificate(student_name: String, course: String, grade: String, ctx: &mut TxContext) {
        let owner = tx_context::sender(ctx);
        let student_certificate = StudentCertificate {
            id: object::new(ctx),
            student_name,
            course,
            grade,
        };
        transfer::public_transfer(student_certificate, owner);
    }

    fun certfified(student_name: String, course: String, grade: String) {
        event::emit(StudentCertified {
            student_name,
            course,
            grade,
        })
    }
}

module hello_sui::game_admin {
    use sui::balance::{Self, Balance};
    use sui::coin::{Self, Coin};
    use sui::event;
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    const E_GAME_NOT_ACTIVE: u64 = 0;

    public struct SUI has drop {}

    public struct Game has key, store {
        id: UID,
        paused: bool,
        reward_rate: u64,
    }
    public struct Treasury has key, store {
        id: UID,
        funds: Balance<SUI>,
    }
    public struct AdminCap has key, store {
        id: UID,
    }
    public struct TreasuryCap has key, store {
        id: UID,
    }

    public struct GamePaused has copy, drop {
        paused: bool,
    }
    public struct GameResumed has copy, drop {
        paused: bool,
    }
    public struct GameInitialized has copy, drop {
        paused: bool,
        reward_rate: u64,
    }
    public struct RewardRateUpdated has copy, drop {
        reward_rate: u64,
    }

    fun initialize(paused: bool, reward_rate: u64, ctx: &mut TxContext) {
        let initializer = tx_context::sender(ctx);
        let game = Game {
            id: object::new(ctx),
            paused,
            reward_rate,
        };
        transfer::public_transfer(game, initializer);
        event::emit(GameInitialized {
            paused,
            reward_rate,
        })
    }

    public fun pause(_: &AdminCap, game: &mut Game) {
        game.paused = true;
        event::emit(GamePaused {
            paused: game.paused,
        })
    }

    public fun resume(_: &AdminCap, game: &mut Game) {
        game.paused = false;
        event::emit(GameResumed {
            paused: game.paused,
        })
    }

    public fun update_reward_rate(_: &AdminCap, new_rate: u64, game: &mut Game) {
        game.reward_rate = new_rate;
        event::emit(RewardRateUpdated {
            reward_rate: game.reward_rate,
        })
    }

    public fun withdraw_treasury(_: &TreasuryCap, treasury: Treasury, ctx: &mut TxContext) {
        let Treasury { id, funds } = treasury;
        let coin = coin::from_balance(funds, ctx);
        let teamTreasury = tx_context::sender(ctx);
        transfer::public_transfer(coin, teamTreasury);
    }

    public fun play(game: &mut Game) {
        assert!(!game.paused, E_GAME_NOT_ACTIVE);
    }
}

module hello_sui::dynamic_hero {
    use std::string::String;
    use sui::dynamic_field as df;

    public struct Hero has key, store {
        id: UID,
        name: vector<u8>,
        level: u64,
    }

    public struct Additional_data has drop, store {
        weapons: String,
        pets: String,
        achievements: String,
        titles: String,
        cosmetics: u64,
    }

    public fun dynamic_data(
        hero: &mut Hero,
        key_name: String,
        weapons: String,
        pets: String,
        achievements: String,
        titles: String,
        cosmetics: u64,
    ) {
        let additional_data = Additional_data {
            weapons,
            pets,
            achievements,
            titles,
            cosmetics,
        };

        df::add(&mut hero.id, key_name, additional_data);
    }
}
