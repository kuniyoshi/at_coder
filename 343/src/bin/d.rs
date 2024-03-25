use std::io::{self, BufRead};
use std::collections::HashMap;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, t): (usize, usize) = {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1])
    };
    let events: Vec<(usize, usize)> = (0..t).map(|_| {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0] - 1, list[1])
    }).collect();

    let mut scores = vec![0; n];

    let mut map = HashMap::new();
    map.insert(0, n);

    for &(who, addition) in &events {
        let entry = map.entry(scores[who]).or_insert(0);
        *entry -= 1;

        if *entry == 0 {
            map.remove(&scores[who]);
        }

        scores[who] += addition;
        *map.entry(scores[who]).or_insert(0) += 1;

        println!("{}", map.len());
    }
}
