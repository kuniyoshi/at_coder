fn main() {
    proconio::input! {
        n: u64,
        m: u64,
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", (n, m));

    let mut total = 0;
    let unit = 998244353;

    for i in 0..60_u64 {
        if (n & (1 << i)) > 0 {
            total += count(i, m);
            total %= unit;
        }
    }

    println!("{}", total);
}

fn count(a: u64, b: u64) -> u64 {
    if a == 0 {
        return 0;
    }
    popcount(((1 << a) - 1) & b) * 2_u64.pow((a - 1) as u32)
}

fn popcount(a: u64) -> u64 {
    a.count_ones() as u64
}
