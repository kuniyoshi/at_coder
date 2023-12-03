use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let a: Vec<usize> = lines
        .next()
        .unwrap()
        .unwrap()
        .split_whitespace()
        .map(|s| s.parse().unwrap())
        .collect();

    let mut chlidren_list: Vec<Vec<usize>> = vec![Vec::new(); n];

    // 1 1 3 2 4 4
    // 1 -> 0
    // 2 -> 0
    // 3 -> 2
    // 4 -> 1
    // 5 -> 3
    // 6 -> 3
    for i in 0..a.len() {
        chlidren_list[a[i] - 1].push(i + 1);
    }

    let mut counts: Vec<usize> = vec![0; n];

    count(&mut counts, &chlidren_list, 0);

    for c in &counts {
        print!("{} ", c);
    }

    println!("");
}

fn count(counts: &mut Vec<usize>, chlidren_list: &Vec<Vec<usize>>, who: usize) -> usize {
    let mut acc: usize = 0;
    
    for child in &chlidren_list[who] {
        acc += count(counts, chlidren_list, *child) + 1;
    }

    // println!("{} -> {}", who, acc);
    counts[who] = acc;

    acc
}