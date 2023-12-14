use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (h, w, k): (usize, usize, usize) = {
        let list: Vec<usize> = lines
            .next()
            .unwrap()
            .unwrap()
            .split_whitespace()
            .map(|s| s.parse().unwrap())
            .collect();
        (list[0], list[1], list[2])
    };
    let mut cells: Vec<Vec<char>> = (0..h)
        .map(|_| lines.next().unwrap().unwrap().chars().collect())
        .collect();

    for _ in 0..k {
        let mut row_max: (usize, usize) = (0, 0);

        for i in 0..h {
            let count: usize = cells[i].iter().map(|c| if *c == '.' { 1 } else { 0 }).sum();

            if count > row_max.0 {
                row_max = (count, i);
            }
        }

        let mut col_max: (usize, usize) = (0, 0);

        for j in 0..w {
            let count: usize = (0..h).map(|i| if cells[i][j] == '.' { 1 } else { 0 }).sum();

            if count > col_max.0 {
                col_max = (count, j);
            }
        }

        if row_max.0 >= col_max.0 {
            for j in 0..w {
                cells[row_max.1][j] = '#';
            }
        } else {
            for i in 0..h {
                cells[i][col_max.1] = '#';
            }
        }
    }

    let count: usize = cells
        .iter()
        .map(|cols| cols.iter().map(|c| if *c == '#' { 1 } else { 0 }).sum::<usize>())
        .sum();
    println!("{}", count);
}
