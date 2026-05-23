/*#[test_only]
module hello_sui::hello_sui_tests;

use hello_sui::exercise;

#[error(code = 0)]
const ENotImplemented: vector<u8> = b"Not Implemented";

#[test]
fun test_hello_sui() {
    // pass
}

#[test, expected_failure(abort_code = ::hello_sui::hello_sui_tests::ENotImplemented)]
fun test_hello_sui_fail() {
    abort ENotImplemented
}*/

