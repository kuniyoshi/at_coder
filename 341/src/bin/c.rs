use std::io::{self, BufRead};

struct P {
    i: i32,
    j: i32,
}

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (h, w): (usize, usize) = {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1])
    };
    let moves: Vec<char> = lines.next().unwrap().unwrap().chars().collect();
    let cells: Vec<Vec<char>> = (0..h).map(|_| lines.next().unwrap().unwrap().chars().collect()).collect();

    let mut candidates: Vec<P> = Vec::new();

    for i in 0..h {
        for j in 0..w {
            if cells[i][j] == '.' {
                candidates.push(P { i: i as i32, j: j as i32 });
            }
        }
    }

    for i in 0..moves.len() {
        let mut next_candidates: Vec<P> = Vec::new();

        let to = match moves[i] {
            'L' => P { i: 0, j: -1 },
            'D' => P { i: 1, j: 0 },
            'U' => P { i: -1, j: 0 },
            'R' => P { i: 0, j: 1 },
            _ => panic!("Invalid move"),
        };

        for p in &candidates {
            if cells[(p.i + to.i) as usize][(p.j + to.j) as usize] == '.' {
                next_candidates.push(P { i: p.i + to.i, j: p.j + to.j });
            }
        }

        candidates = next_candidates;
    }

    println!("{}", candidates.len());
}
