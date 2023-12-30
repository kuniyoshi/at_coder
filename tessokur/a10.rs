use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let a: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
    let d: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let spans: Vec<(usize, usize)> = (0..d).map(|_| {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1])
    }).collect();

    let max: usize = *a.iter().max().unwrap();

    let mut sizes: Vec<Vec<usize>> = vec![vec![0; n + 1]; max + 1];

    for i in 0..n {
        sizes[a[i]][i + 1] += 1;
    }

    for i in 0..=max {
        for j in 1..=n {
            sizes[i][j] += sizes[i][j - 1];
        }
    }

    // 1 2 3 4 5 6 7 <- days
    // 1 2 5 5 2 3 1 <- sizes
    // 3 5
    // 4 6
    // eprintln!("{:?}", sizes);

    'LOOP:
    for &(l, r) in &spans {
        for i in (0..=max).rev() {
            if sizes[i][l - 1] > 0 || sizes[i][n] - sizes[i][r] > 0 {
                println!("{}", i);
                continue 'LOOP;
            }
        }

        panic!("Could not find size");
    }
}