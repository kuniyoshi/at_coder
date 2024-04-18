fn main() {
    proconio::input! {
        n: usize,
    };
    proconio::input! {
        a: [i32; n - 1],
    };

    let sum: i32 = a.iter().sum();
    println!("{}", -sum);
}
