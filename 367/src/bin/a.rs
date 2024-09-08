fn main() {
    proconio::input! {
        a: u64,
        b: u64,
        c: u64,
    };

    if b < c {
        if b < a && a < c {
            println!("No");
        } else {
            println!("Yes");
        }
    } else {
        if b < a || a < c {
            println!("No");
        } else {
            println!("Yes");
        }
    }
}
