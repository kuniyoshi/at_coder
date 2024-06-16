fn main() {
    proconio::input! {
        n: usize,
        l: usize,
        r: usize,
    };
    let mut a: Vec<_> = (1..=n).collect();
    let b: Vec<_> = ((l-1)..=(r-1)).map(|i| a[i]).rev().collect();

    for i in 0..b.len() {
        a[l - 1 + i] = b[i];
    }

    for i in 0..a.len() {
        print!("{} ", a[i]);
    }

    println!();
}
