use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (a, b): (i64, i64) = {
        let list: Vec<i64> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1])
    };

    println!("{}", power(a, b));
}

fn power(mut a: i64, mut b: i64) -> i64 {
    let mut result = 1;

    while b > 0 {
        if b % 2 == 1 {
            result *= a;
        }
        a *= a;
        b /= 2;

        a %= 1_000_000_007;
        result %= 1_000_000_007;
    }

    result
}