fn main() {
    proconio::input! {
        _: usize,
        s: proconio::marker::Chars,
    };

    let count = s.windows(3).filter(|t| t == &&['#', '.', '#']).count();

    println!("{}", count);
}
