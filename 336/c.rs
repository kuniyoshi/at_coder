use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();

    println!("{}", five(n - 1));
}

fn five(value: usize) -> usize {
    let mut unit: usize = 0;

    while pow(5, unit) < value {
        unit += 1;
    }

    let mut remain = value;
    let mut bits: Vec<usize> = Vec::new();

    for i in (0..unit).rev() {
        bits.push(remain / pow(5, i));
        remain -= (remain / pow(5, i)) * pow(5, i);
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", bits);

    let mut result = 0;
    let map: Vec<usize> = vec![0, 2, 4, 6, 8];

    for i in 0..bits.len() {
        result += map[bits[i]] * pow(10, bits.len() - i - 1);
    }

    result
}

fn pow(a: usize, mut b: usize) -> usize {
    let mut result = 1;

    while b > 0 {
        result *= a;
        b -= 1;
    }

    result
}