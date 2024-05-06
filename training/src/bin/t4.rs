fn main() {
    proconio::input! {
        n: usize,
        a: [i32; n],
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", a);

    let mut max = 0;
    let mut acc = 0;

    for v in &a {
        acc = (acc + v).max(*v);
        max = max.max(acc);
    }

    println!("{}", max);
}