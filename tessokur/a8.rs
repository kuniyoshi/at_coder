use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (h, w): (usize, usize) = {
        let list: Vec<usize> = lines
            .next()
            .unwrap()
            .unwrap()
            .split_whitespace()
            .map(|s| s.parse().unwrap())
            .collect();
        (list[0], list[1])
    };
    let cells: Vec<Vec<usize>> = (0..h)
        .map(|_| {
            lines
                .next()
                .unwrap()
                .unwrap()
                .split_whitespace()
                .map(|s| s.parse().unwrap())
                .collect()
        })
        .collect();
    let q: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let queries: Vec<(usize, usize, usize, usize)> = (0..q)
        .map(|_| {
            let list: Vec<usize> = lines
                .next()
                .unwrap()
                .unwrap()
                .split_whitespace()
                .map(|s| s.parse().unwrap())
                .collect();
            (list[0], list[1], list[2], list[3])
        })
        .collect();

    let mut totals: Vec<Vec<usize>> = vec![vec![0; w + 1]; h + 1];

    for i in 1..=h {
        for j in 1..=w {
            totals[i][j] = cells[i - 1][j - 1] + totals[i][j - 1];
        }
    }

    for i in 1..=h {
        for j in 1..=w {
            totals[i][j] = totals[i][j] + totals[i - 1][j];
        }
    }

    for &(a, b, c, d) in &queries {
        let upper_left: (usize, usize) = (a - 1, b - 1);
        let upper_right: (usize, usize) = (a - 1, d);
        let lower_left: (usize, usize) = (c, b - 1);
        let lower_right: (usize, usize) = (c, d);

        println!(
            "{}",
            totals[lower_right.0][lower_right.1] + totals[upper_left.0][upper_left.1]
                - totals[upper_right.0][upper_right.1]
                - totals[lower_left.0][lower_left.1]
        );
    }
}
