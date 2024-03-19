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
    let c = x / lcm(n, m);
    let d = a + b - 2 * c;
    d
}

fn lcm(a: usize, b: usize) -> usize {
    a * b / gcd(a.max(b), b.min(a))
}

fn gcd(a: usize, b: usize) -> usize {
    if b == 0 {
        a
    }
    else {
        gcd(b, a % b)
    }
}

fn bin2(n: usize, m: usize, k: usize, mut a: usize) -> usize {
    while d(n, m, a - 1) == k {
        a -= 1;
    }

    while a % n != 0 && a % m != 0 {
        a += 1;
    }

    a
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