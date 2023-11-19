use fmt::Debug;
use std::collections::HashMap;
use std::fmt;
use std::io::{self, BufRead};
use std::str;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, m): (usize, usize) = read_two(&mut lines);
    let a: Vec<usize> = read_list(&mut lines);

    let mut votes: Vec<usize> = vec![0; n];
    let mut order: Vec<usize> = (0..n).collect();
    let mut order_indexes: Vec<usize> = (0..n).collect();
    let mut count: HashMap<usize, usize> = HashMap::new();

    count.entry(0).or_insert(m);

    for i in 0..m {
        votes[a[i] - 1] += 1;
        // eprintln!("### {}", a[i]);
        // eprintln!("{:?}", votes);
        // eprintln!("{:?}", order);
        // eprintln!("{:?}", order_indexes);
        assert!(votes[a[i] - 1] >= 1);
        *count.entry(votes[a[i] - 1] - 1).or_insert(0) -= 1;
        *count.entry(votes[a[i] - 1]).or_insert(0) += 1;

        loop {
            let index = order_indexes[a[i] - 1];

            if index != 0 {
                let upper = order[index - 1];

                if votes[a[i] - 1] > votes[upper] {
                    let top = order[index - count.get(&votes[upper]).unwrap()];
                    order.swap(order_indexes[top], index);
                    order_indexes.swap(top, a[i] - 1);
                    continue;
                }

                if votes[a[i] - 1] == votes[upper] && a[i] - 1 < upper {
                    order.swap(order_indexes[upper], index);
                    order_indexes.swap(upper, a[i] - 1);
                    continue;
                }
            }

            break;
        }

        println!("{}", order[0] + 1);
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
