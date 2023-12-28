use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let d: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let spans: Vec<(i32, i32)> = (0..n).map(|_| {
        let list: Vec<i32> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1])
    }).collect();

    // eprintln!("{:?}", spans);

    let mut counts: Vec<i32> = vec![0; d + 1];

    for &(l, r) in &spans {
        counts[(l - 1) as usize] += 1;
        counts[(r) as usize] -= 1;
    }

    // [(2, 3), (3, 6), (5, 7), (3, 7), (1, 5)]
    // 1 2 3 4 5 6 7
    //   ---
    //     -------
    //         -----
    //     ---------
    // ---------
    // [1, 1, 1, 0, 0, -1, -2, 0]
    // 1 2 3 3 3 2 0 0
    // eprintln!("{:?}", counts);

    let mut acc: i32 = 0;

    for i in 0..d {
        acc += counts[i as usize] as i32;
        println!("{}", acc);
    }
}