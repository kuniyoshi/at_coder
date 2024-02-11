use std::io::{self, BufRead};

struct P {
    h: usize,
    w: usize,
}

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (h, w, n): (usize, usize, usize) = {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1], list[2])
    };

    // false は白, true は黒
    let mut cells: Vec<Vec<bool>> = vec![vec![false; w]; h];

    let directions: Vec<(i32, i32)> = vec![(-1, 0), (0, 1), (1, 0), (0, -1)];
    let mut current_direction: usize = 0;
    let mut p: P = P { h: 0, w: 0 };

    for _ in 0..n {
        match cells[p.h][p.w] {
            false => {
                cells[p.h][p.w] = true;
                current_direction = (current_direction + 1) % directions.len();
                let d = directions[current_direction];
                p = P { h: clamp(p.h, d.0, h), w: clamp(p.w, d.1, w) };
            },
            _ => {
                cells[p.h][p.w] = false;
                current_direction = match current_direction { 0 => directions.len() - 1, _ => current_direction - 1 };
                let d = directions[current_direction];
                p = P { h: clamp(p.h, d.0, h), w: clamp(p.w, d.1, w) };
            },
        }
    }

    for i in 0..h {
        for j in 0..w {
            print!("{}", match cells[i][j] { true => '#', false => '.' });
        }

        println!("");
    }
}

fn clamp(current: usize, delta: i32, clamp: usize) -> usize {
    if delta >= 0 {
        return (current + delta as usize) % clamp;
    }

    if delta.abs() as usize <= current {
        return (current as i32 - delta.abs()) as usize;
    }

    // 0, -1, 2 -> 1
    return (clamp as i32 - delta.abs()) as usize;
}