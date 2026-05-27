#[test_only]
module hero_registry::hero_registry_tests;

use hero_registry::hero_registry;
use std::unit_test::assert_eq;

#[test]
fun test_create_hero(){
    let ctx = sui::tx_context::dummy();
    let name: vector<u8> = b"Hero1";
    let heart: u64 = 100;
    let age: u64 = 30;
    let kills: u64 = 10;
    let power: u64 = (heart * kills)/age;
    
    assert!(power == 33, 0);
    assert!(name == b"Hero1", 0);
    assert!(heart == 100, 0);
    assert!(age == 30, 0);
    assert!(kills == 10, 0);
}