use std::io::{self, BufRead};
use std::collections::HashMap;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let a: Vec<i32> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();

    let mut previous: HashMap<usize, usize> = HashMap::new();

    for i in 0..n {
        previous.insert(if a[i] == -1 { 0 as usize } else { a[i] as usize }, i);
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", previous);
    // {4: 0, 1: 1, 0: 2, 5: 3, 2: 5, 3: 4}

    // i: 0 1  2 3 4 5
    // a: 4 1 -1 5 3 2
    // o: 3 4  0 2 1 5
    // r: 3 5 4 1 2 6

    let mut orders: Vec<(usize, usize)> = Vec::new();
    let mut cursor: usize = 0;

    while orders.len() != n {
        orders.push((orders.len(), previous[&cursor]));
        cursor = previous[&cursor] + 1;
        // orders.push( previous[&orders.len()] + 1);
        // cursor = previous[orders.len()]
    }

    orders.sort();

    // [(0, 2), (3, 4), (5, 3), (4, 0), (1, 1), (2, 5)]
    // [(0, 2), (1, 1), (2, 5), (3, 4), (4, 0), (5, 3)]

    for &(_, v) in &orders {
        print!("{} ", v + 1);
    }

    println!("");

    // let mut numbers: Vec<(usize, usize)> = Vec::new();


    // for i in 0..n {
    //     if !previous.contains_key(&i) {
    //         orders[i] = 0;
    //         continue;
    //     }

    //     let j = previous[&i];
    //     orders[i] = orders[j] + 1;
    // }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", orders);

    // [2, 1, 5, 4, 0, 3]
    // 5 2 1 6 4 3
}