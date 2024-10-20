use std::collections::VecDeque;

fn main() {
    proconio::input! {
        n: usize,
        m: usize,
        edgeds: [(usize, usize, i64); m],
    };

    let mut links = vec![vec![]; n];

    for &(u, v, w) in &edgeds {
        links[u - 1].push((v - 1, w));
    }

    let mut in_edge_counts = vec![0_u64; n];

    for i in 0..n {
        for &(v, _) in &links[i] {
            in_edge_counts[v] += 1;
        }
    }

    let mut results = vec![None; n];

    let mut orders: Vec<_> = in_edge_counts
        .iter()
        .enumerate()
        .map(|(i, u)| (u, i))
        .collect();
    orders.sort();

    #[cfg(debug_assertions)]
    eprintln!("orders: {:?}", &orders);

    for &(_, u) in &orders {
        if results[u].is_some() {
            continue;
        }

        let mut value = None;

        for &(v, w) in &links[u] {
            if results[v].is_some() {
                value = Some(results[v].unwrap() - w);
                break;
            }
        }

        let mut queue = VecDeque::new();
        queue.push_back((u, value.unwrap_or(0)));

        while let Some((u, value)) = queue.pop_front() {
            results[u] = Some(value);

            for &(v, w) in &links[u] {
                if results[v].is_some() {
                    continue;
                }

                queue.push_back((v, value + w));
            }
        }

        #[cfg(debug_assertions)]
        eprintln!("{:?}", &results);
    }

    for i in 0..n {
        print!("{} ", results[i].unwrap());
    }

    println!("");
}
