module hello_sui::inventory{
    use std::vector;

    public fun test_inventory(){
        let mut items: vector<u64> = vector[];

        vector::push_back(
            &mut items,
            10
        );
        vector::push_back(
            &mut items,
            20
        );

        let first = vector::borrow(
            &items,
            0
        );

        let total = vector::length(
            &items
        );
    }
}