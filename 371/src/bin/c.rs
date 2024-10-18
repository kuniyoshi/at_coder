fn main() {
    proconio::input! {
        n: usize,
        mg: usize,
        edges_g: [(usize, usize); mg],
        mh: usize,
        edges_h: [(usize, usize); mh],
    };

    let mut costs = Vec::new();

    for i in 0..n {
        proconio::input! {
            new: [u64; n - i - 1],
        };

        let mut row = vec![0; i + 1];
        row.extend(new);
        costs.push(row);
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", &costs);

    let mut links_g = vec![vec![]; n];

    for &(from, to) in &edges_g {
        links_g[from - 1].push(to - 1);
        links_g[to - 1].push(from - 1);
    }

    let mut links_h = vec![vec![]; n];

    for &(from, to) in &edges_h {
        links_h[from - 1].push(to - 1);
        links_h[to - 1].push(from - 1);
    }

    let mut orders: Vec<usize> = (0..n).collect();
    let mut min = costs.iter().map(|list| list.iter().sum::<u64>()).sum::<u64>();

    loop {
        let mut total = 0;

        for (gi, &hi) in orders.iter().enumerate() {
            for i in 0..n {
                let has_g_it = links_g[gi].contains(&i);
                let has_h_it = links_h[hi].contains(&i);

                if has_g_it != has_h_it {
                    let from = hi.min(i);
                    let to = hi.max(i);
                    // #[cfg(debug_assertions)]
                    // eprintln!("{:?}", (from, to));

                    total += costs[from][to];
                }
            }
        }

        // 1 -> 4
        // 2 -> 1
        // 3 -> 2
        // 4 -> 5
        // 5 -> 3
        // 3, 0, 1, 4, 2 -> 46

        #[cfg(debug_assertions)]
        eprintln!("{:?}", (&orders, total));

        min = min.min(total);

        if !next_permutation(&mut orders) {
            break;
        }
    };

    println!("{}", min);
}

fn next_permutation(orders: &mut Vec<usize>) -> bool {
    let n = orders.len();
    let mut i = n - 1;
    while i > 0 && orders[i - 1] >= orders[i] {
        i -= 1;
    }
    if i == 0 {
        return false;
    }
    
    let mut j = n - 1;
    while orders[j] <= orders[i - 1] {
        j -= 1;
    }
    
    orders.swap(i - 1, j);
    orders[i..].reverse();
    true
}
