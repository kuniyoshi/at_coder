use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let q: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
    let a: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
    let b: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();

    let a_counts = counts(&q, &a);

    #[cfg(debug_assertions)]
    eprintln!("{:?}", a_counts);

    let max_a = a_counts.iter().min().unwrap();
    let mut global_max: usize = 0;

    for i in 0..=(*max_a) {
        let remain_q = remain(&q, &a, i);
        let b_counts = counts(&remain_q, &b);
        let max_b = b_counts.iter().min().unwrap();
        global_max = global_max.max(i + max_b);
    }

    println!("{}", global_max);
}

fn remain(q: &Vec<usize>, a: &Vec<usize>, count: usize) -> Vec<usize> {
    let mut result = vec![0; a.len()];

    for i in 0..a.len() {
        result[i] = q[i] - a[i] * count;
    }

    result
}

fn infinity() -> usize {
    1_000_000_001
}

fn counts(q: &Vec<usize>, a: &Vec<usize>) -> Vec<usize> {
    let mut counts: Vec<usize> = vec![infinity(); a.len()];

    for i in 0..a.len() {
        if a[i] == 0 {
            continue;
        }
        counts[i] = q[i] / a[i];
    }

    counts
}