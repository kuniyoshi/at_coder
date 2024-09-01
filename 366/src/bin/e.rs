fn main() {
    proconio::input! {
        n: usize,
        d: u64,
        points: [(i64, i64); n],
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", (n, d, &points));
}
