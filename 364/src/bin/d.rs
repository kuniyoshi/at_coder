fn main() {
    proconio::input! {
        n: usize,
        q: usize,
        a: [i64; n],
        queries: [(i64, usize); q],
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", (n, q, &a, &queries));

    for &(b, k) in &queries {
        // let bi = bin(&a, b);

        let mut lwa = n - 1;
        let mut lac = 0;
        let mut rwa = 0;
        let mut rac = n - 1;

        while (lwa - lac) != 1 || (rac - rwa) != 1 {
            if lwa - lac == 1 {
                // r をやる
                continue;
            }
            if rac - rwa == 1 {
                // l をやる
                continue;
            }

            unreachable!();
            if distance(&a, lac, b) > distance(&a, rac, b) {

            let lwj = (lac + lwa) / 2;
            let rwj = (rac + rwa) / 2;

            if rac - lac + 1 > k {
                    if 
                }
            }
        }

        println!("{}", (a[rac] - b).max(b - a[lac]));
    }
}

fn distance(a: &Vec<i64>, index: usize, b: i64) -> i64 {
    (a[index] - b).abs()
}