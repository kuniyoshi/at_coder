fn main() {
    proconio::input! {
        l: u64,
        r: u64,
    };

    match (l, r) {
        (1, 0) => println!("Yes"),
        (0, 1) => println!("No"),
        _ => println!("Invalid"),
    };
}
