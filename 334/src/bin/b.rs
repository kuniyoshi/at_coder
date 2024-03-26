use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (m, l, r): (i64, i64, i64) = {
        let list: Vec<i64> = lines
            .next()
            .unwrap()
            .unwrap()
            .split_whitespace()
            .map(|s| s.parse().unwrap())
            .collect();
        (list[1], list[2] - list[0], list[3] - list[0])
    };

    // 5 3
    // -4 -1 2 5 8 11 14
    // 0 3 6
    // 1 4 7
    // 7

    match (l >= 0, r >= 0) {
        // [3, 3]
        // 0, 3
        (true, true) => {
            let right = r / m;
            let left = l / m;
            println!("{}", right - left + zero(l, r));
        }
        // [-6, 1]
        // -6 -3 0 3
        (false, true) => {
            let right = r / m;
            let left = l / m;
            println!("{}", right + left.abs() + zero(l, r));
        }
        // -8 -1
        // -9 -6 -3 0
        (false, false) => {
            let right = r / m;
            let left = l / m;
            println!("{}", left.abs() - right.abs() + zero(l, r));
        }
        (_, _) => panic!("invalid"),
    }
}

fn zero(l: i64, r: i64) -> i64 {
    if l < 0 {
        if r >= 0 {
            return 1;
        } else {
            return 0;
        }
    } else if l == 0 {
        return 1;
    } else {
        return 0;
    }
}
