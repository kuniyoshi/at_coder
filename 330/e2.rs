use fmt::Debug;
use std::cmp::Reverse;
use std::collections::{BinaryHeap, HashMap};
use std::fmt;
use std::io::{self, BufRead};
use std::str;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, q): (usize, usize) = read_two(&mut lines);
    let mut a: Vec<usize> = read_list(&mut lines);
    let queries: Vec<(usize, usize)> = (0..q)
        .map(|_| {
            let parts: Vec<usize> = lines
                .next()
                .unwrap()
                .unwrap()
                .split_whitespace()
                .map(|s| s.parse().unwrap())
                .collect();
            (parts[0] - 1, parts[1])
        })
        .collect();

    let mut map: HashMap<usize, usize> = HashMap::new();

    for i in 0..n {
        *map.entry(a[i]).or_insert(0) += 1;
    }

    let mut queue: BinaryHeap<(Reverse<usize>, usize)> = BinaryHeap::new();
    let mut generation: usize = 0;

    for i in 0..(2 * n) {
        if map.contains_key(&i) {
            continue;
        }

        queue.push((Reverse(i), generation));
    }

    let mut generations: Vec<usize> = vec![generation; n];

    for i in 0..q {
        let (index, x) = queries[i];

        *map.entry(a[index]).or_insert(1) -= 1;

        generation += 1;
        generations[index] = generation;

        if *map.get(&a[index]).unwrap_or(&0) <= 0 {
            map.remove(&a[index]);
            queue.push((Reverse(a[index]), generations[index]));
        }

        a[index] = x;
        *map.entry(x).or_insert(0) += 1;

        while queue.peek().is_some() && map.contains_key(&queue.peek().unwrap().0.0) {
            queue.pop().unwrap();
        }

        println!("{}", queue.peek().unwrap().0.0);
    }
}

fn read_list<A: str::FromStr>(lines: &mut io::Lines<io::StdinLock>) -> Vec<A>
where
    A::Err: Debug + 'static,
{
    let line = lines.next().unwrap().unwrap();
    line.split_whitespace()
        .map(|s| s.parse().unwrap())
        .collect()
}

fn read_two<A: str::FromStr, B: str::FromStr>(lines: &mut io::Lines<io::StdinLock>) -> (A, B)
where
    A::Err: Debug + 'static,
    B::Err: Debug + 'static,
{
    let line = lines.next().unwrap().unwrap();
    let mut parts = line.split_whitespace();
    let a: A = parts.next().unwrap().parse().unwrap();
    let b: B = parts.next().unwrap().parse().unwrap();
    (a, b)
}
