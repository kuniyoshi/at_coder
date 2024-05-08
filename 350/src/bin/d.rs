use std::collections::{HashSet, VecDeque};

fn main() {
    proconio::input! {
        n: usize,
        m: usize,
        edges: [(usize, usize); m],
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", edges);

    let mut links: Vec<Vec<usize>> = vec![Vec::new(); n];

    for &(a, b) in &edges {
        let u = a - 1;
        let v = b - 1;
        links[u].push(v);
        links[v].push(u);
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", links);

    let mut visited = HashSet::new();
    let mut total = 0;

    for i in 0..n {
        if visited.contains(&i) {
            continue;
        }

        let mut chunk = HashSet::new();

        let mut queue = VecDeque::new();
        queue.push_back(i);

        while let Some(u) = queue.pop_front() {
            if visited.contains(&u) {
                continue;
            }

            visited.insert(u);
            chunk.insert(u);

            for v in &links[u] {
                if visited.contains(v) {
                    continue;
                }

                queue.push_back(*v);
            }
        }

        let mut current = 0;

        for u in &chunk {
            current += links[*u].len();
        }

        total += (chunk.len() * (chunk.len() - 1) / 2) - current / 2;
    }

    println!("{}", total);
}
