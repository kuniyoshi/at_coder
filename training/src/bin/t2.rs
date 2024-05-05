use std::collections::HashSet;

#[derive(Eq, PartialEq)]
#[derive(Hash)]
#[derive(Copy, Clone)]
#[derive(Debug)]
struct P {
    i: usize,
    j: usize,
}

#[derive(Copy, Clone, Debug)]
enum Direction {
    Right,
    Down,
    Left,
    Up,
}

impl P {
    fn go(&self, direction: Direction, h: usize, w: usize) -> Option<P> {
        match direction {
            Direction::Right if self.j + 1 < w => Some(P { i: self.i, j: self.j + 1 }),
            Direction::Right => None,
            Direction::Down if self.i + 1 < h => Some(P { i: self.i + 1, j: self.j }),
            Direction::Down => None,
            Direction::Left if self.j > 0 => Some(P { i: self.i, j: self.j - 1 }),
            Direction::Left => None,
            Direction::Up if self.i > 0 => Some(P { i: self.i - 1, j: self.j }),
            Direction::Up => None,
        }
    }
}

impl Direction {
    fn next(&self) -> Self {
        match self {
            Direction::Right => Direction::Down,
            Direction::Down => Direction::Left,
            Direction::Left => Direction::Up,
            Direction::Up => Direction::Right,
        }
    }
}

fn main() {
    proconio::input! {
        h: usize,
        w: usize,
        matrix: [[usize; w]; h],
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", matrix);

    let mut direction = Direction::Right;
    let mut visited = HashSet::new();
    let mut current = P { i: 0, j: 0 };

    loop {
        #[cfg(debug_assertions)]
        eprintln!("{:?}", direction);

        while !visited.contains(&current) {
            print!("{} ", matrix[current.i][current.j]);
            visited.insert(current);

            if let Some(new) = current.go(direction, h, w) {
                if visited.contains(&new) {
                    break;
                }
                current = new;
            } else {
                break;
            }
        }

        direction = direction.next();

        if let Some(new) = current.go(direction, h, w) {
            current = new;
        } else {
            #[cfg(debug_assertions)]
            eprintln!("break next");
            break;
        }

        if visited.contains(&current) {
            #[cfg(debug_assertions)]
            eprintln!("{:?}", current);
            #[cfg(debug_assertions)]
            eprintln!("break contains");
            break;
        }
    }
}