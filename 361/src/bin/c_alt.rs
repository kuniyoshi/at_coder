fn main() {
    proconio::input! {
        n: usize,
        k: usize,
        mut a: [u64; n],
    };

    a.sort();

    let mut p1 = 0;
    let mut p2 = n - k - 1;

    let mut min = a.last().unwrap() - a.first().unwrap();

    for _ in 0..n {
        match (a.get(p1), a.get(p2)) {
            (Some(l), Some(r)) => min = min.min(r - l),
            _ => (),
        };

        p1 += 1;
        p2 += 1;
    }

    println!("{}", min);
}