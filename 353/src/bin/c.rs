fn main() {
    proconio::input! {
        n: usize,
        a: [usize; n],
    };

    let mut acc = Vec::new();
    acc.push(0);

    for i in 0..n {
        let last = acc.last().unwrap();
        acc.push(last + a[i])
    }

    let base = 100_000_000;
    let mut total = 0;

    for i in 0..(n - 1) {
        let addition = a[i] * (n - i - 1) + acc.last().unwrap() - acc[i + 1];
        total += addition % base;
    }

    println!("{}", total);
}
