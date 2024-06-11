fn main() {
    proconio::input! {
        n: usize,
        mut a: [usize; n],
    };

    a.sort();

    let base = 100_000_000;
    let mut total = 0;
    let mut overs = 0;

    for a_value in &a {
        total += a_value * (n - 1);
        let bin_a = bin(&a, base - a_value);
        let bin_b = bin(&a, a_value + 1);

        if bin_a > 0 && bin_a > bin_b {
            overs += bin_a - bin_b;
        }

        #[cfg(debug_assertions)]
        eprintln!("{:?}", (a_value, bin_a, bin_b));
    }

    println!("{}", total - overs * base);
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
