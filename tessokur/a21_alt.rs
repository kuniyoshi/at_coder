use std::io::{self, BufRead};
use std::collections::HashMap;

struct P {
    conditions: Vec<(usize, usize)>,
    n: usize,
}

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let conditions: Vec<(usize, usize)> = (0..n).map(|_| {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1])
    }).collect();

    #[cfg(debug_assertions)]
    eprintln!("{:?}", conditions);

    let mut cache: HashMap<(usize, usize), usize> = HashMap::new();

    dfs(&mut cache, 0, 0, 0, &(P { conditions, n }));

    #[cfg(debug_assertions)]
    eprintln!("{:?}", cache);

    println!("{}", cache.values().max().unwrap());
}

fn dfs(cache: &mut HashMap<(usize, usize), usize>, score: usize, left: usize, right: usize, p: &P) {
    if left + right >= p.n {
        return;
    }

    if cache.contains_key(&(left, right)) {
        return;
    }

    let addition_left: usize = if left < p.conditions[left].0 && p.conditions[left].0 < p.n - right {
        p.conditions[left].1
    } else { 0 };
    let max_left: usize = match cache.get(&(left + 1, right)) {
        Some(value) => *value.max(&(score + addition_left)),
        _ => score + addition_left,
    };

    let addition_right: usize = if right < p.conditions[right].0 && p.conditions[right].0 < p.n - right {
        p.conditions[right].1
    } else { 0 };
    let max_right: usize = match cache.get(&(left, right + 1)) {
        Some(value) => *value.max(&(score + addition_right)),
        _ => score + addition_right,
    };

    cache.insert((left, right), max_left.max(max_right));

    dfs(cache, max_left, left + 1, right, p);
    dfs(cache, max_right, left, right + 1, p);
}