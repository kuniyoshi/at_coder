use std::{collections::HashMap, io::{self, BufRead}};

struct Bean {
    tasty: usize,
    color: usize,
}

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let beans: Vec<Bean> = (0..n).map(|_| {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        Bean { tasty: list[0], color: list[1] }
    }).collect();

    let mut min = HashMap::new();

    for bean in &beans {
        let tasty = min.entry(bean.color).or_insert(bean.tasty).clone();
        min.insert(bean.color, bean.tasty.min(tasty));
    }

    println!("{}", min.values().max().unwrap());
}
