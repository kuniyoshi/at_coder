fn main() {
    proconio::input! {
        r: u64,
        g: u64,
        b: u64,
        c: String,
    };

    match c.as_str() {
        "Red" => println!("{}", g.min(b)),
        "Green" => println!("{}", r.min(b)),
        "Blue" => println!("{}", r.min(g)),
        _ => unreachable!(),
    };
}
