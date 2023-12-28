use std::io::{self, BufRead};
use std::collections::{HashSet,VecDeque};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, m): (usize, usize) = {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1])
    };
    let edges: Vec<(usize, usize, usize)> = (0..m).map(|_| {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0] - 1, list[1] - 1, list[2])
    }).collect();

    let mut links: Vec<Vec<(usize, usize)>> = vec![Vec::new(); n];

    for &(u, v, c) in &edges {
        links[u].push((v, c));
        links[v].push((u, c));
    }

    let mut queue: VecDeque<(usize, usize)> = VecDeque::new();
    queue.push_back((0, 0));

    let mut distance: Vec<Option<usize>> = vec![None; n];

    while queue.len() > 0 {
        let (u, c) = queue.pop_front().unwrap();

        match distance[u] {
            Some(current) if current <= c => continue,
            _ => distance[u] = Some(c),
        }

        for &(v, cost) in &links[u] {
            match distance[v] {
                Some(current) if current <= cost => continue,
                _ => queue.push_back((v, c + cost)),
            }
        }
    }

    let mut passed: HashSet<usize> = HashSet::new();
    let mut ways: VecDeque<usize> = VecDeque::new();
    ways.push_back(n - 1);

    while ways.len() > 0 {
        let u = ways.pop_front().unwrap();

        if passed.contains(&u) {
            continue;
        }

        passed.insert(u);

        for &(v, cost) in &links[u] {
            if passed.contains(&v) {
                continue;
            }
            if distance[v].is_some() && cost <= distance[u].unwrap() && distance[v].unwrap() == distance[u].unwrap() - cost {
                ways.push_back(v);
            }
        }
    }

    println!("{}", passed.len());

    // let mut possibles: Vec<usize> = passed.iter().map(|v| v.clone()).collect();
    // possibles.sort();

    // for i in 0..possibles.len() {
    //     print!("{} ", possibles[i] + 1);
    // }

    // println!("");
}