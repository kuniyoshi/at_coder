use std::collections::HashSet;

fn main() {
    proconio::input! {
        n: usize,
        k: usize,
        edges: [(usize, usize); n - 1],
        v: [usize; k],
    };

    let mut links = vec![vec![]; n];

    for &(u, v) in &edges {
        links[u - 1].push(v - 1);
        links[v - 1].push(u - 1);
    }

    let set: HashSet<usize> = v.iter().map(|v| v - 1).collect();

    println!("{}", dfs(v[0] - 1, None, &links, &set));
}

fn dfs(u: usize, parent: Option<usize>, edges: &Vec<Vec<usize>>, set: &HashSet<usize>) -> u64 {
    let mut total = 0;

    for v in &edges[u] {
        if parent.is_some_and(|some| some == *v) {
            continue;
        }

        total += dfs(*v, Some(u), edges, set);
    }

    if total > 0 || set.contains(&u) {
        total += 1;
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", (u, parent, total));

    total
}
