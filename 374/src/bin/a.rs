fn main() {
    proconio::input! {
        s: String,
    };

    if s.ends_with("san") {
        println!("Yes");
    } else {
        println!("No");
    }
}
