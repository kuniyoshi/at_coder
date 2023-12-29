use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (h, w, n): (usize, usize, usize) = {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1], list[2])
    };
    let snows: Vec<(usize, usize, usize, usize)> = (0..n).map(|_| {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1], list[2], list[3])
    }).collect();

    let mut map: Vec<Vec<i32>> = vec![vec![0; w + 1]; h+1];

    for &(a, b, c, d) in &snows {
        map[c][d] += 1;
        map[a - 1][b - 1] += 1;
        map[a - 1][d] -= 1;
        map[c][b - 1] -= 1;
    }

    for i in 0..=h {
        for j in 1..=w {
            map[i][j] += map[i][j - 1];
        }
    }

    for i in 1..=h {
        for j in 0..=w {
            map[i][j] += map[i - 1][j];
        }
    }

    for i in 0..h {
        for j in 0..w {
            print!("{} ", map[i][j])
        }

        println!("");
    }
}
