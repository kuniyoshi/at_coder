use std::collections::HashSet;

fn main() {
    proconio::input! {
        h: usize,
        w: usize,
        m: usize,
    };
    proconio::input! {
        mut queries: [(usize, usize, usize); m],
    };

    queries.reverse();

    let mut used = vec![HashSet::new(); 2]; // h, w
    let mut count = vec![0; *queries.iter().map(|(_, _, x)| x).max().unwrap() + 1];
    let len = vec![h, w];

    for (t, a, x) in queries.iter().map(|(t, a, x)| (t - 1, a - 1, x)) {
        if used[t].contains(&a) {
            continue;
        }

        used[t].insert(a);

        count[*x] += len[t] - used[t ^ 1].len();
    }

    println!("{}", count.iter().filter(|v| v > &&0).count());

    let maps: Vec<_> = count.iter().enumerate().filter(|(_, v)| v > &&0).collect();

    for &(i, v) in &maps {
        println!("{} {}", i, v);
    }
}
