use std::io::{self, BufRead};

fn is_in_range(i: i32, n: usize) -> bool {
    i >= 0 && i < n as i32
}

fn is_in_range2(p: (i32, i32), n: usize) -> bool {
    is_in_range(p.0, n) && is_in_range(p.1, n)
}

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();

    let mut grid: Vec<Vec<i32>> = vec![vec![-1; n]; n];

    #[cfg(debug_assertions)]
    eprintln!("{:?}", grid);

    let directions: Vec<(i32, i32)> = vec![
        (0, 1),
        (1, 0),
        (0, -1),
        (-1, 0),
    ];

    let mut next_position: (usize, usize) = (0, 0);
    let mut next_parts: usize = 1;
    let mut di: usize = 0;

    while grid[next_position.0][next_position.1] == -1 {
        grid[next_position.0][next_position.1] = next_parts as i32;
        next_parts += 1;

        let mut candidate = (next_position.0 as i32 + directions[di % directions.len()].0, next_position.1 as i32 + directions[di % directions.len()].1);

        if !is_in_range2(candidate, n) || grid[candidate.0 as usize][candidate.1 as usize] != -1 {
            di += 1;
            candidate = (next_position.0 as i32 + directions[di % directions.len()].0, next_position.1 as i32 + directions[di % directions.len()].1);
        }

        next_position = (candidate.0 as usize, candidate.1 as usize);
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", directions);

    grid[n / 2][n / 2] = 0;

    for i in 0..n {
        for j in 0..n {
            if grid[i][j] == 0 {
                print!("{} ", 'T');
            } else {
                print!("{} ", grid[i][j]);
            }
        }

        println!("");
    }
}