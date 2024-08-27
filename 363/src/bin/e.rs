use std::{
    cmp::Reverse,
    collections::{BinaryHeap, VecDeque},
};

enum Direction {
    Up,
    Down,
    Left,
    Right,
}

fn main() {
    proconio::input! {
        h: usize,
        w: usize,
        y: usize,
        a: [[u64; w]; h],
    };

    let mut remains = BinaryHeap::new();
    let mut unders = vec![0; y + 1];
    let mut is_under = vec![vec![false; w]; h];

    for i in 0..h {
        for j in 0..w {
            remains.push((Reverse(&a[i][j]), (i, j)));
        }
    }

    let directions = [Direction::Up, Direction::Down, Direction::Left, Direction::Right];

    while let Some((Reverse(&border), (base_i, base_j))) = remains.pop() {
        if is_under[base_i][base_j] {
            continue;
        }

        #[cfg(debug_assertions)]
        eprintln!("{:?}", ("border", border));

        let mut queue = VecDeque::new();

        queue.push_back((base_i, base_j));

        while let Some((i, j)) = queue.pop_front() {
            if is_under[i][j] {
                continue;
            }

            is_under[i][j] = true;

            if border < unders.len() as u64 {
                unders[border as usize] += 1;
            }

            for direction in &directions {
                match coord(i, j, direction) {
                    Some((next_i, next_j)) => {
                        if is_under_already(&is_under, next_i, next_j) {
                            continue;
                        }

                        if is_under_new(&a, &border, next_i, next_j) {
                            queue.push_back((next_i, next_j))
                        }
                    },
                    _ => continue,
                };
            }
        }
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", unders);

    #[cfg(debug_assertions)]
    eprintln!("{:?}", is_under);
}

fn is_under_new(a: &Vec<Vec<u64>>, border: &u64, i: usize, j: usize) -> bool {
    match a.get(i).and_then(|vec| vec.get(j)) {
        Some(value) => value <= border,
        _ => false,
    }
}

fn is_under_already(a: &Vec<Vec<bool>>, i: usize, j: usize) -> bool {
    *a.get(i).and_then(|vec| vec.get(j)).unwrap_or(&false)
}

fn coord(i: usize, j: usize, direction: &Direction) -> Option<(usize, usize)> {
    match direction {
        Direction::Up => i.checked_sub(1).and_then(|checked_i| Some((checked_i, j))),
        Direction::Down => Some((i + 1, j)),
        Direction::Left => j.checked_sub(1).and_then(|checked_j| Some((i, checked_j))),
        Direction::Right => Some((i, j + 1)),
    }
}
