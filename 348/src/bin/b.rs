use std::io::{self, BufRead};

struct P {
    x: i32,
    y: i32,
}

impl P {
    fn distance(&self, other: &P) -> usize {
        ((self.x - other.x) * (self.x - other.x) + (self.y - other.y) *(self.y - other.y)) as usize
    }
}

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let points: Vec<P> = (0..n).map(|_| {
        let list: Vec<i32> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        P { x: list[0], y: list[1] }
    }).collect();

    // TODO: 浮動小数でも落ちない?

    for i in 0..n {
        let mut farthest = i;

        for j in 0..n {
            if points[i].distance(&points[j]) > points[i].distance(&points[farthest]) {
                farthest = j;
            }
        }

        println!("{}", farthest + 1);
    }
}
