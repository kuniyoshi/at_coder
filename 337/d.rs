use std::io::{self, BufRead};
use std::collections::HashMap;

fn infinity(h: usize, w: usize) -> usize {
    h + w
}

fn calc_min(cells: &Vec<Vec<char>>, h: usize, w: usize, k: usize) -> usize {
    if w < k {
        return infinity(h, w);
    }

    let mut min = infinity(h, w);

    for i in 0..h {
        let chars = &cells[i];
        let mut count_of: HashMap<char, usize> = HashMap::new();
        count_of.insert('o', 0);
        count_of.insert('x', 0);
        count_of.insert('.', 0);

        for j in 0..k {
            *count_of.entry(chars[j]).or_insert(0) += 1;
        }

        if count_of[&'x'] == 0 {
            min = min.min(count_of[&'.']);
        }

        for j in k..w {
            *count_of.entry(chars[j - k]).or_insert(0) -= 1;
            *count_of.entry(chars[j]).or_insert(0) += 1;

            if count_of[&'x'] == 0 {
                min = min.min(count_of[&'.']);
            }
        }
    }

    min
}


fn main() {
    let mut lines = io::stdin().lock().lines();
    let (h, w, k): (usize, usize, usize) = {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1], list[2])
    };
    let cells: Vec<Vec<char>> = (0..h).map(|_| lines.next().unwrap().unwrap().chars().collect()).collect();
    // #[cfg(debug_assertions)]
    // eprintln!("{:?}", cells);

    let mut min = infinity(h, w);
    min = min.min(calc_min(&cells, h, w, k));

    let mut t_cells: Vec<Vec<char>> = vec![vec![' '; h]; w];

    for i in 0..h {
        for j in 0..w {
            t_cells[j][i] = cells[i][j];
        }
    }

    min = min.min(calc_min(&t_cells, w, h, k));

    if min == infinity(h, w) {
        println!("-1");
    }
    else {
        println!("{}", min);
    }
}