#[test_only]
module hero_registry::hero_registry_tests;

use hero_registry::hero_registry;
use std::unit_test::assert_eq;

#[test]
fun test_create_hero(){
    let mut ctx = sui::tx_context::dummy();
    let name = b"Hero1";
    let heart = 100;
    let age = 30;
    let kills = 10;
    
    assert!(power == 33, 0);
    assert!(name == b"Hero1", 0);
    assert!(heart == 100, 0);
    assert!(age == 30, 0);
    assert!(kills == 10, 0);
}