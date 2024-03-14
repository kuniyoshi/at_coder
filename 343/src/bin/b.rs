use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let adjacency: Vec<Vec<usize>> = (0..n).map(|_| {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        list
    }).collect();

    for i in 0..n {
        for j in 0..n {
            if adjacency[i][j] == 1 {
                print!("{} ", j + 1);
            }
        }

        println!("");
    }
}
