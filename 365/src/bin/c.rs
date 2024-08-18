fn main() {
    proconio::input! {
        n: usize,
        m: u64,
        a: [u64; n],
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", (n, m, &a));

    if a.iter().sum::<u64>() <= m {
        println!("infinite");
        return;
    }

    let mut ac = 1;
    let mut wa = m;

    while wa - ac > 1 {
        let wj = (ac + wa) / 2;

        if bin(&a, m, wj) {
            ac = wj;
        } else {
            wa = wj;
        }
    }

    println!("{}", ac);
}

fn bin(a: &Vec<u64>, m: u64, candidate: u64) -> bool {
    a.iter().map(|v| v.min(&candidate)).sum::<u64>() <= m
}
