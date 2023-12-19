use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let edges: Vec<(usize, usize)> = (0..(n - 1))
        .map(|_| {
            let list: Vec<usize> = lines
                .next()
                .unwrap()
                .unwrap()
                .split_whitespace()
                .map(|s| s.parse().unwrap())
                .collect();
            (list[0] - 1, list[1] - 1)
        })
        .collect();

    let mut links: Vec<Vec<usize>> = vec![Vec::new(); n];

    for (u, v) in &edges {
        links[*u].push(*v);
        links[*v].push(*u);
    }

    let mut children: Vec<usize> = Vec::new();

    for &child in &links[0] {
        children.push(min_children(child, 0, &links));
    }

    if children.len() == 1 {
        println!("{}", 1);
        return;
    }

    let max = *children.iter().max().unwrap();
    let sum: usize = children.iter().sum();
    println!("{}", sum - max + 1);
}

fn min_children(a: usize, parent: usize, links: &Vec<Vec<usize>>) -> usize {
    if links[a].iter().filter(|v| *v != &parent).count() == 0 {
        return 1;
    }

    let mut min: usize = 0;

    for &child in &links[a] {
        if child == parent {
            continue;
        }
        min += min_children(child, a, links);
    }

    min + 1
}
