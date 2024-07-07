fn main() {
    proconio::input! {
        n: usize,
        colors: [u64; 2 * n],
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", colors);

    // TODO: デストラクションが使えない
    println!("{}", colors.windows(3).filter(|w| w[0] == w[2] && w[0] != w[1]).count());
}