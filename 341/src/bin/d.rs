use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, m, k): (usize, usize, usize) = {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1], list[2])
    };

    println!("{}", bin(n, m, k));
}

fn d(n: usize, m: usize, x: usize) -> usize {
    let a = x / n;
    let b = x / m;
    let c = x / (n * m);
    let d = a + b - 2 * c;
    d
}

fn bin2(n: usize, m: usize, k: usize, a: usize) -> usize {
    let mut left = a;
    let mut right = a;

    while d(n, m, left - 1) == k {
        left -= 1;
    }

    while d(n, m, right + 1) == k {
        right += 1;
    }

    while right - left > 1 {
        let middle = (left + right) / 2;
        if (d(n, m, middle) == )
    }
}

fn bin(n: usize, m: usize, k: usize) -> usize {
    let mut right: usize = 3e18 as usize;
    let mut left: usize = 1;

    while right - left > 1 {
        let middle = (left + right) / 2;

        if d(n, m, middle) == k {
            return bin2(n, m, k, middle);
        }

        if d(n, m, middle) <= k {
            left = middle;
        }
        else {
            right = middle;
        }
    }

    left
}