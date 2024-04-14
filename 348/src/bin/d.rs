use std::{
    cmp::Reverse, collections::{BinaryHeap, HashMap, HashSet}, io::{self, BufRead}
};

struct P {
    i: usize,
    j: usize,
    genre: usize, // 0: Start, 1: Goal, 2: Medicine
    be: usize,    // Start, Goal は 0
}

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (h, w): (usize, usize) = {
        let list: Vec<usize> = lines
            .next()
            .unwrap()
            .unwrap()
            .split_whitespace()
            .map(|s| s.parse().unwrap())
            .collect();
        (list[0], list[1])
    };
    let cells: Vec<Vec<char>> = (0..h)
        .map(|_| lines.next().unwrap().unwrap().chars().collect())
        .collect();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let mut points: Vec<P> = (0..n)
        .map(|_| {
            let list: Vec<usize> = lines
                .next()
                .unwrap()
                .unwrap()
                .split_whitespace()
                .map(|s| s.parse().unwrap())
                .collect();
            P {
                i: list[0] - 1,
                j: list[1] - 1,
                genre: 2,
                be: list[2],
            }
        })
        .collect();

    for i in 0..h {
        for j in 0..w {
            if cells[i][j] == 'S' {
                points.push(P {
                    i,
                    j,
                    genre: 0,
                    be: 0,
                });
            }
        }
    }

    for i in 0..h {
        for j in 0..w {
            if cells[i][j] == 'T' {
                points.push(P {
                    i,
                    j,
                    genre: 1,
                    be: 0,
                });
            }
        }
    }

    let mut index = HashMap::new();

    for i in 0..(points.len() - 2) {
        index.insert((points[i].i, points[i].j), i);
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", index);

    let mut distances = vec![vec![Option::<usize>::None; n + 2]; n + 2]; // n は Start, n + 1 は Goal

    for i in 0..points.len() {
        let mut d = vec![vec![Option::<usize>::None; w]; h];
        let mut queue = BinaryHeap::new();
        queue.push(Reverse((0, points[i].i, points[i].j)));

        while let Some(Reverse((nd, ni, nj))) = queue.pop() {
            match d[ni][nj] {
                Some(v) if v <= nd => continue,
                _ => {
                    d[ni][nj] = Some(nd);
                    match index.get(&(ni, nj)) {
                        Some(idx) => distances[i][*idx] = Some(nd),
                        _ => (),
                    }
                    if points[n + 0].i == ni && points[n + 0].j == nj {
                        distances[i][n] = Some(nd);
                    }
                    if points[n + 1].i == ni && points[n + 1].j == nj {
                        distances[i][n + 1] = Some(nd);
                    }

                    if ni != 0 && cells[ni - 1][nj] != '#' { // ここのフィルタもあるよい
                        queue.push(Reverse((nd + 1, ni - 1, nj)));
                    }
                    if ni < h - 1 && cells[ni + 1][nj] != '#' {
                        queue.push(Reverse((nd + 1, ni + 1, nj)));
                    }
                    if nj != 0 && cells[ni][nj - 1] != '#' {
                        queue.push(Reverse((nd + 1, ni, nj - 1)));
                    }
                    if nj < w - 1 && cells[ni][nj + 1] != '#' {
                        queue.push(Reverse((nd + 1, ni, nj + 1)));
                    }
                }
            }
        }
    }

    let mut visited = HashSet::new();

    if dfs(n, 0, &mut visited, &points, &distances) {
        println!("Yes");
    } else {
        println!("No");
    }
}

fn dfs(
    current: usize,
    energy: usize,
    visited: &mut HashSet<usize>,
    points: &Vec<P>,
    distances: &Vec<Vec<Option<usize>>>,
) -> bool {
    if current == points.len() - 1 {
        return true;
    }

    let candidates: Vec<_> = distances[current]
        .iter()
        .enumerate()
        .filter(|(_, v)| match v {
            Some(d) if d <= &&energy => true,
            _ => false,
        })
        .map(|(i, _)| i)
        .collect();

    for candidate in &candidates {
        if visited.contains(candidate) {
            continue;
        }

        let new_energy = energy - distances[current][*candidate].unwrap();
        if points[*candidate].genre != 1 && new_energy >= points[*candidate].be {
            continue;
        }

        visited.insert(*candidate);
        let result = dfs(
            *candidate,
            points[*candidate].be,
            visited,
            points,
            distances,
        );
        if result {
            return true;
        }
        visited.remove(&candidate);
    }

    false
}
