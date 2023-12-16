use std::io::{self, BufRead};

fn bits(i: usize) -> usize {
    let mut count: usize = 0;
    let mut z = i as usize;

    while z > 0 {
        if z & 1 > 0 {
            count += 1;
        }

        z >>= 1;
    }

    count
}

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
    let cells: Vec<Vec<char>> = (0..h)
        .map(|_| lines.next().unwrap().unwrap().chars().collect())
        .collect();

    let max = 2_i32.pow(h as u32) as usize;
    let mut result: usize = 0;

    for i in 0..max {
        if bits(i) > k {
            continue;
        }

        let mut buffer = cells.clone();
        let mut index: usize = 0;

        while (1 << index) <= i {
            if (1 << index) & i > 0 {
                buffer[index] = std::iter::repeat('#').take(w).collect();
            }

            index += 1;
        }

        let remain = k - bits(i);

        let mut indexes: Vec<usize> = (0..w).collect();
        indexes.sort_by(|a, b| {
            (0..h)
                .filter(|hi| buffer[*hi][*b] == '#')
                .count()
                .cmp(&(0..h).filter(|hi| buffer[*hi][*a] == '#').count())
        });

        for j in indexes.iter().take(remain) {
            for k in 0..h {
                buffer[k][*j] = '#';
            }
        }

        result = result.max(
            (0..h)
                .map(|hi| buffer[hi].iter().filter(|c| *c == &'#').count())
                .sum(),
        );
    }

    println!("{}", result);
}
