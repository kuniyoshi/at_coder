use std::{
    collections::{HashSet, VecDeque},
    io::{self, BufRead},
};

#[derive(Clone, Hash, PartialEq, Eq, Copy, Debug)]
struct P {
    i: i32,
    j: i32,
}

#[derive(Clone, Hash, PartialEq, Eq, Copy, Debug)]
struct Q {
    p: P,
    d: P,
}

impl P {
    fn add(&self, other: &P) -> P {
        P {
            i: self.i + other.i,
            j: self.j + other.j,
        }
    }
}

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, _): (usize, usize) = {
        let list: Vec<usize> = lines
            .next()
            .unwrap()
            .unwrap()
            .split_whitespace()
            .map(|s| s.parse().unwrap())
            .collect();
        (list[0], list[1])
    };
    let cells: Vec<Vec<char>> = (0..n)
        .map(|_| lines.next().unwrap().unwrap().chars().collect())
        .collect();

    let directions = vec![
        P { i: -1, j: 0 },
        P { i: 0, j: 1 },
        P { i: 1, j: 0 },
        P { i: 0, j: -1 },
    ];

    let mut queue = VecDeque::new();

    for d in &directions {
        queue.push_back(Q {
            p: P { i: 1, j: 1 },
            d: d.clone(),
        });
    }

    let mut visited = HashSet::new();

    while let Some(q) = queue.pop_front() {
        if visited.contains(&q) {
            continue;
        }

        visited.insert(q);

        for d in &directions {
            let mut next = q.p.clone();

            while cells[next.add(d).i as usize][next.add(d).j as usize] == '.' {
                next = next.add(d);
            }

            for dd in &directions {
                let new_q = Q {
                    p: next,
                    d: dd.clone(),
                };

                if !visited.contains(&new_q) {
                    queue.push_back(new_q);
                }
            }
        }
    }

    let mut visitable = HashSet::new();

    for q in visited.iter() {
        let mut p = q.p.clone();
        let d = q.d.clone();
        visitable.insert(p);

        while cells[p.add(&d).i as usize][p.add(&d).j as usize] == '.' {
            p = p.add(&d);
            visitable.insert(p);
        }
    }

    println!("{}", visitable.len());
}
