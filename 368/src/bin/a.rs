fn main() {
    proconio::input! {
        n: usize,
        k: usize,
        a: [u64; n],
    };

    let top: Vec<_> = a.iter().rev().take(k).rev().collect();
    let bottom: Vec<_> = a.iter().take(n - k).collect();

    for v in &top {
        print!("{} ", v);
    }

    for v in &bottom {
        print!("{} ", v);
    }

    println!("");
}
