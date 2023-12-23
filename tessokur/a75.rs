use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let problems: Vec<(usize, usize)> = (0..n)
        .map(|_| {
            let list: Vec<usize> = lines
                .next()
                .unwrap()
                .unwrap()
                .split_whitespace()
                .map(|s| s.parse().unwrap())
                .collect();
            (list[0], list[1])
        })
        .collect();

    let mut dp: Vec<Vec<usize>> = vec![vec![]; 1440];

    //  0  1  2  3  4  5  6  7  8  9 10
    //        -------
    //           -------
    //              -------
    //                 -------
}
