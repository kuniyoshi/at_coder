use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let mut p: Vec<Vec<usize>> = (0..n)
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

    let mut swaps: usize = 0;

    for i in 1..=n {
        let mut row_index = p
            .iter()
            .enumerate()
            .find_map(|(index, cols)| if cols.contains(&i) { Some(index) } else { None })
            .unwrap();

        while row_index != i - 1 {
            p.swap(row_index, row_index - 1);
            row_index -= 1;
            swaps += 1;
        }

        let mut col_index = (0..n)
            .map(|index| (0..n).map(|hi| p[hi][index]).collect::<Vec<usize>>())
            .enumerate()
            .find_map(|(index, rows)| if rows.contains(&i) { Some(index) } else { None })
            .unwrap();

        while col_index != i - 1 {
            for cols in &mut p {
                cols.swap(col_index, col_index - 1);
            }

            col_index -= 1;
            swaps += 1;
        }
    }

    println!("{}", swaps);
}
