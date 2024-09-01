fn main() {
    proconio::input! {
        n: u64,
        t: u64,
        a: u64,
    };

    if t.max(a) > n / 2 {
        println!("Yes");
    } else {
        println!("No");
    }
}
