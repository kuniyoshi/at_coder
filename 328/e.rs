use fmt::Debug;
use std::cmp;
use std::fmt;
use std::io::{self, BufRead};
use std::str;

struct P {
    n: usize,
    m: usize,
    k: usize,
    edges: Vec<(usize, usize, usize)>,
}

fn bits(mut bits: usize) -> usize {
    let mut count: usize = 0;

    while bits > 0 {
        if bits & 1 > 0 {
            count += 1;
        }

        bits >>= 1;
    }

    count
}

fn cost(used: usize, p: &P) -> usize {
    let mut cost: usize = 0;

    for i in 0..p.m {
        if (used & 1 << i) > 0 {
            cost += p.edges[i].2 % p.k;
        }
    }

    cost % p.k
}

fn dfs(visited: usize, used: usize, p: &P) -> Option<usize> {
    if visited == (1 << p.n) - 1 {
        return if bits(used) == p.n - 1 {
            Some(cost(used, p))
        } else {
            None
        };
    }

    let mut min: Option<usize> = None;

    for i in 0..p.m {
        if (used & 1 << i) > 0 {
            continue;
        }

        let new_visited = visited | 1 << p.edges[i].0 | 1 << p.edges[i].1;

        min = min_or(min, dfs(new_visited, used | 1 << i, p));
    }

    min
}

fn min_or(a: Option<usize>, b: Option<usize>) -> Option<usize> {
    match (a, b) {
        (Some(a_value), Some(b_value)) => Some(cmp::min(a_value, b_value)),
        (Some(_), _) => a,
        (_, _) => b,
    }
}

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, m, k): (usize, usize, usize) = read_three(&mut lines);
    let edges: Vec<(usize, usize, usize)> = (0..m)
        .map(|_| {
            let (a, b, c): (usize, usize, usize) = read_three(&mut lines);
            (a - 1, b - 1, c)
        })
        .collect();

    println!("{}", dfs(0, 0, &P { n, m, k, edges }).unwrap());

    // let mut min = k - 1;

    // 'LOOP: for flags in 0..(1 << m) {
    //     let mut cost = 0;
    //     let mut vertexes: usize = 0;
    //     let mut marked: usize = 0;

    //     for i in 0..m {
    //         if (1 << i) & flags > 0 {
    //             cost += edges[i].2;
    //             vertexes |= 1 << edges[i].0;
    //             vertexes |= 1 << edges[i].1;
    //             marked += 1;
    //         }

    //         if marked > n - 1 {
    //             continue 'LOOP;
    //         }
    //     }

    //     if marked != n - 1 {
    //         continue;
    //     }

    //     if vertexes != (1 << n) - 1 {
    //         continue;
    //     }

    //     cost %= k;

    //     // println!("flags: {:b}, {}", flags, cost);

    //     min = cmp::min(min, cost);
    // }

    // println!("{}", min);
}

fn read_three<A: str::FromStr, B: str::FromStr, C: str::FromStr>(
    lines: &mut io::Lines<io::StdinLock>,
) -> (A, B, C)
where
    A::Err: Debug + 'static,
    B::Err: Debug + 'static,
    C::Err: Debug + 'static,
{
    let line = lines.next().unwrap().unwrap();
    let mut parts = line.split_whitespace();
    let a: A = parts.next().unwrap().parse().unwrap();
    let b: B = parts.next().unwrap().parse().unwrap();
    let c: C = parts.next().unwrap().parse().unwrap();
    (a, b, c)
}
