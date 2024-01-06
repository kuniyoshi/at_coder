use std::io::{self, BufRead};

struct P {
    n: usize,
    a: Vec<usize>,
    b: Vec<usize>,
}

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let a: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
    let b: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();

    let mut cache: Vec<Option<usize>> = vec![None; n];

    println!("{}", dfs(&mut cache, 0, 0, &(P { n, a, b })));
}

fn dfs(cache: &mut Vec<Option<usize>>, current: usize, score: usize, p: &P) -> usize {
    if current >= p.n - 1 {
        return score;
    }

    if let Some(value) = cache[current] {
        return value;
    }

    let a: usize = dfs(cache, p.a[current] - 1, score + 100, p);
    let b: usize = dfs(cache, p.b[current] - 1, score + 150, p);

    cache[current] = Some(a.max(b));

    a.max(b)
}