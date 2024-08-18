fn main() {
    proconio::input! {
        n: usize,
        a: [u64; n],
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", a);

    let mut pairs: Vec<_> = a.iter().enumerate().map(|(i, v)| (v, i + 1)).collect();
    pairs.sort();

    println!("{}",
    pairs[pairs.len() - 2].1
);
}
