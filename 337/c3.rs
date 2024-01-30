use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let a: Vec<i32> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();

    // 6
    // 4 1 -1 5 3 2
    // 3 -> 0
    // 0 -> 1
    // 
    // 4 -> 3
    // 2 -> 4
    // 1 -> 5
    // 1 5 4 0 3 6


    let mut nexts: Vec<usize> = vec![n; n];

    for i in 0..n {
        if a[i] == -1 {
            continue;
        }
        let previous = (a[i] - 1) as usize;

        nexts[previous] = i;
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", nexts);

    // let first = a.iter().position(|&v| v == -1).unwrap();

    // let mut orders: Vec<usize> = vec![first];

    // while orders.len() != n {
    //     orders.push(neighbors[*orders.last().unwrap()][0]);
    // }

    // #[cfg(debug_assertions)]
    // eprintln!("{:?}", orders);
}