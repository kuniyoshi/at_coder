use std::collections::{HashSet, VecDeque};

fn main() {
    proconio::input! {
        n: usize,
        k: u64,
        edges: [(usize, usize); n - 1],
        v: [usize; k],
    };

    let set: HashSet<usize> = v.iter().map(|v| v - 1).collect();
    let mut links = vec![HashSet::new(); n];

    for &(from, to) in &edges {
        links[from - 1].insert(to - 1);
        links[to - 1].insert(from - 1);
    }

    let mut cleared = 0;

    let mut queue: VecDeque<usize> = (0..n).collect();

    while let Some(u) = queue.pop_front() {
        if set.contains(&u) {
            continue;
        }

        if links[u].len() != 1 {
            continue;
        }

        let v = *links[u].iter().next().unwrap();
        links[v].remove(&u);
        links[u].clear();
        queue.push_back(v);

        cleared += 1;
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", links);

    println!("{}", n - cleared);
}
