use fmt::Debug;
use std::collections::HashMap;
use std::fmt;
use std::io::{self, BufRead};
use std::str;
use std::cmp;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, m, k): (usize, usize, usize) = read_three(&mut lines);
    let edges: Vec<(usize, usize, usize)> = (0..m).map(|_| {
        let (a, b, c): (usize, usize, usize) = read_three(&mut lines);
        (a - 1, b - 1, c)
    }).collect();

    let mut min: usize = k - 1;

    'LOOP:
    for flags in 0..(1 << m) {
        let mut bit_count = 0;
        let mut cost = 0;
        let mut bits = flags;
        let mut vertexes = 0_usize;

        // println!("flags: {:b}", flags);

        while bits > 0 {
            if (bits & 1) == 1 {
                // println!("take {}", bit_count);
                // println!("bit_count: {}", bit_count);
                println!("cost: {}", edges[bit_count].2);
                cost += edges[bit_count].2;
                // if (vertexes & 1 << ((edges[bit_count].0 - 1))) > 0 {
                //     continue 'LOOP;
                // }
                vertexes |= 1 << edges[bit_count].0;
                // if (vertexes & (1 << (edges[bit_count].1 - 1))) > 0 {
                //     continue 'LOOP;
                // }
                vertexes |= 1 << edges[bit_count].1;
                // println!("{}:{}", edges[bit_count].0, edges[bit_count].1);
                bit_count += 1;
            }
            bits >>= 1;
            if bit_count > n { // なぜ
                continue 'LOOP;
            }
        }

        // println!("vertexes: {:b}", vertexes);
        // println!("{}", bit_count);

        if bit_count != n {
            continue;
        }

        println!("vertexes: {:b}", vertexes);

        if vertexes != (1 << n) - 1 {
            continue;
        }

        // cost %= k;

        println!("flags: {:b}, {}", flags, cost);

        min = cmp::min(min, cost);
    }

    println!("{}", min);
}

fn yes_no(is_yes: bool) -> &'static str {
    if is_yes {
        "Yes"
    } else {
        "No"
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

fn read_four<A: str::FromStr, B: str::FromStr, C: str::FromStr, D: str::FromStr>(
    lines: &mut io::Lines<io::StdinLock>,
) -> (A, B, C, D)
where
    A::Err: Debug + 'static,
    B::Err: Debug + 'static,
    C::Err: Debug + 'static,
    D::Err: Debug + 'static,
{
    let line = lines.next().unwrap().unwrap();
    let mut parts = line.split_whitespace();
    let a: A = parts.next().unwrap().parse().unwrap();
    let b: B = parts.next().unwrap().parse().unwrap();
    let c: C = parts.next().unwrap().parse().unwrap();
    let d: D = parts.next().unwrap().parse().unwrap();
    (a, b, c, d)
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

fn read_one<A: str::FromStr>(lines: &mut io::Lines<io::StdinLock>) -> A
where
    A::Err: Debug + 'static,
{
    lines.next().unwrap().unwrap().parse().unwrap()
}
