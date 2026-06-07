module hello_sui::student {
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::event;

    use sui::transfer;

    public struct Student has key, store{
        id: UID,
        owner: address,
        name: vector<u8>,
    }
    public struct StudentRegistered has copy, drop{
        owner: address,
        name: vector<u8>,
    }

    entry fun create_student(
        name: vector<u8>,
        ctx: &mut TxContext
    ){
        let owner = tx_context::sender(ctx);

        let student = Student{
            id: object::new(ctx),
            owner,
            name
        };

        transfer::freeze_object(student);

        event::emit(
            StudentRegistered{
        owner,
        name
    }
        );
    }
}