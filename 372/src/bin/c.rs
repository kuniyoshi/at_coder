fn main() {
    proconio::input! {
        n: usize,
        q: usize,
        mut s: proconio::marker::Chars,
        queries: [(usize, char); q],
    };

    let mut count = count_abc(&s);

    // #[cfg(debug_assertions)]
    // eprintln!("{:?}", count);

    for &(x, c) in &queries {
        let current = count_abc(&indexes(x, n).iter().map(|i| s[*i]).collect());
        s[x - 1] = c;

        let after = count_abc(&indexes(x, n).iter().map(|i| s[*i]).collect());

        // #[cfg(debug_assertions)]
        // eprintln!("{:?}", s);

        // #[cfg(debug_assertions)]
        // eprintln!("{:?}", indexes(x, n));

        // #[cfg(debug_assertions)]
        // eprintln!("{:?}", (current, after));

        if after > current {
            count += after - current;
        } else if after < current {
            count -= current - after;
        }

        println!("{}", count);
    }
}

fn indexes(x: usize, n: usize) -> Vec<usize> {
    ((x as i64 - 2)..=(x as i64 + 2))
        .map(|x| x - 1)
        .filter(|x| x >= &0 && x < &(n as i64))
        .map(|x| x as usize)
        .collect()
}

fn count_abc(s: &Vec<char>) -> u64 {
    s.windows(3)
        .filter(|window| window == &['A', 'B', 'C'])
        .count() as u64
}
