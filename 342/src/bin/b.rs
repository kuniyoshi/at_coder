use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let p: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
    let q: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let queries: Vec<(usize, usize)> = (0..q).map(|_| {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0] - 1, list[1] - 1)
    }).collect();

    let mut positions = vec![0; n];

    for i in 0..n {
        positions[p[i] - 1] = i;
    }

    // TODO: ordering 使ってやるにはどうやる？

    for &(a, b) in &queries {
        if positions[a] < positions[b] {
            println!("{}", a + 1);
        } else {
            println!("{}", b + 1);
        }
    }
}
