use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (a, m, l, r): (i64, i64, i64, i64) = {
        let list: Vec<i64> = lines
            .next()
            .unwrap()
            .unwrap()
            .split_whitespace()
            .map(|s| s.parse().unwrap())
            .collect();
        (list[0], list[1], list[2] - list[0], list[3] - list[0])
    };

    // let right = r - l;
    // 5 3
    // -4 -1 2 5 8 11 14
    // 0 3 6
    // 1 4 7
    // 7

    match (l >= 0, r >= 0) {
        //  3   9
        // 0 3 6 9 12
        (true, true) => {
            let right = r / m;
            let left = l / m;
            println!(
                "{}",
                right - left
                    + if l == 0 || r == 0 { 1 } else { 0 }
                    + if left > 0 && left % m == 0 { 1 } else { 0 }
            );
        }
        // -6 1
        // -6 -3 0 3
        (false, true) => {
            let right = r / m + 1;
            let left = l / m;
            println!("{}", right + left.abs() + if r == 0 { 1 } else { 0 });
        }
        // -8 -1
        // -9 -6 -3 0
        (false, false) => {
            let right = r / m;
            let left = l / m;
            println!("{}", right.abs() - left.abs());
        }
        (_, _) => panic!("invalid"),
    }
}
