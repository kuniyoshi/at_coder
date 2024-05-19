fn main() {
    proconio::input! {
        n: usize,
        h: [usize; n],
    };

    let a = h[0];
    let p = h.iter().position(|v| v > &a);

    match p {
        Some(p_value) => println!("{}", p_value + 1),
        _ => println!("{}", -1),
    };
}
