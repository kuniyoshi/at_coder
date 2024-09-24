fn main() {
    proconio::input! {
        n: usize,
        q: usize,
        mut a: [i64; n],
        queries: [(i64, u64); q],
    }

    a.sort();

    #[cfg(debug_assertions)]
    eprintln!("{:?}", (n, q, &a, &queries));

    for &(b, k) in &queries {
        let mut ac = 0;
        let mut wa = 300_000_000;

        // b から距離が ac 以内で゛ある点の数が k 個以内であるかどうか
        while wa - ac > 1 {
            let wj = (ac + wa) / 2;

            if f(wj, b, &a, k) {
                ac = wj;
            } else {
                wa = wj;
            }
        }

        println!("{}", ac);
    }
}

fn f(distance: u64, base: i64, a: &Vec<i64>, k: u64) -> bool {
    match (a.binary_search(&(base - distance as i64)), a.binary_search(&(base + distance as i64 + 1))) {
        (Ok(u), Ok(v)) => v - u + 1 - 1 <= k as usize,
        (Ok(u), Err(v)) => v - u + 1 - 1 <= k as usize,
        (Err(u), Ok(v)) => v - u + 1 - 1 <= k as usize,
        (Err(u), Err(v)) => v - u + 0 - 1 <= k as usize,
    }
}
