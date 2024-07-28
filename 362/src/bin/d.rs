use std::collections::VecDeque;

fn main() {
    proconio::input! {
        n: usize,
        m: usize,
        a: [u64; n],
        edges: [(usize, usize, u64); m],
    };

    let mut costs = vec![None::<u64>; 2 * n];

    let mut links = vec![Vec::new(); 2 * n];

    for i in 0..n {
        links[i].push((i + n, a[i]));
        links[i + n].push((i, a[i]));
    }

    for &(from, to, weight) in &edges {
        links[from - 1 + n].push((to - 1, weight));
        links[to - 1 + n].push((from - 1, weight));
    }

    let mut queue = VecDeque::new();
    queue.push_back((0, 0));

    while let Some((u, c)) = queue.pop_front() {
        if costs[u].is_some_and(|v| v <= c) {
            continue;
        }
        costs[u] = Some(c);

        for i in 0..links[u].len() {
            if costs[links[u][i].0].is_some_and(|c_value| c_value < c + links[u][i].1) {
                continue;
            }

            queue.push_back((links[u][i].0, links[u][i].1 + c));
        }
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", costs);

    for i in (n + 1)..(2 * n) {
        match costs[i] {
            Some(value) => print!("{} ", value),
            None => unreachable!(),
        }
    }

    println!("");
}
