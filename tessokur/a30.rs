use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, r): (usize, usize) = {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1])
    };
    println!("{}", comb(n, r));
}

fn power(mut a: usize, mut b: usize) -> usize {
    let mut result = 1;
    
    while b > 0 {
        if b % 2 == 1 {
            result *= a;
            result %= 1_000_000_007;
        }
        a *= a;
        a %= 1_000_000_007;
        b >>= 1;
    }

    result
}

fn comb(n: usize, r: usize) -> usize {
    let numerator = factorial(n);
    let denominator_1 = factorial(r);
    let denominator_2 = factorial(n - r);

    let denominator = (denominator_1 * denominator_2) % 1_000_000_007;
    let inverse = power(denominator, 1_000_000_007 - 2);

    (numerator * inverse) % 1_000_000_007
}

fn factorial(mut a: usize) -> usize {
    let mut result = 1;

    while a > 0 {
        result *= a;
        result %= 1_000_000_007;
        a -= 1;
    }

    result
}