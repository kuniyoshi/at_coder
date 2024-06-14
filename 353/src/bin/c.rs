fn main() {
    proconio::input! {
        n: usize,
        mut a: [usize; n],
    };

    let base = 100_000_000;

    a.sort();

    for i in 0..n {
        a[i] %= base;
    }

    let mut total = 0;
    let mut overs = 0;

    for a_value in &a {
        total += a_value * (n - 1);
        let bin = bin(&a, base - a_value);

        if a_value > &50_000_000 {
            overs += bin - 1;
        } else {
            overs += bin;
        }
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", (total, overs));

    println!("{}", total - (overs / 2) * base);
}

fn bin(a: &Vec<usize>, value: usize) -> usize {
    if a.first().unwrap() >= &value {
        return a.len();
    }

    if a.last().unwrap() < &value {
        return 0;
    }

    let mut l = 0;
    let mut r = a.len() - 1;

    while r - l > 1 {
        let m = (l + r) / 2;
        if a[m] >= value {
            r = m;
        } else {
            l = m;
        }
    }

    a.len() - r
}
