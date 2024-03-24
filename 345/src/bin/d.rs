use std::io::{self, BufRead};

struct R {
    h: usize,
    w: usize,
}

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, h, w): (usize, usize, usize) = {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1], list[2])
    };
    let bases: Vec<R> = (0..n).map(|_| {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        R { h: list[0], w: list[1] }
    }).collect();

    let mut rectangles_sets = Vec::new();

    for i in 0..(2^n) {
        let mut set = Vec::new();
        for j in 0..n {
            if ((1 << j) & i) == 1 {
                set.push(R { h: bases[j].w, w: bases[j].h });
            }
            else {
                set.push(R { h: bases[j].h, w: bases[j].w });
            }
        }
        rectangles_sets.push(set);
    }

    for set in &rectangles_sets { // 2^7
        let mut order = Vec::new();
        if test(&mut order, set, R { h, w }) { // 7! * h * w
            println!("Yes");
            return;
        }
    }

    println!("No");
}

fn test(order: &mut Vec<usize>, set: &Vec<R>, map: R) -> bool {
    if order.len() == set.len() {
        let mut using = Vec::new();
        for i in order {
            using.push(&set[*i]);
        }
        return t(&using, map);
    }

    for i in 0..set.len() {
        if order.contains(&i) {
            continue;
        }

        order.push(i);

        if test(order, set, R { h: map.h, w: map.w }) {
            return true;
        }

        order.remove(order.len() - 1);
    }

    false
}

fn t(using: &Vec<&R>, map: R) -> bool {
    let mut cells = vec![vec![false; map.w]; map.h];
    let mut cursor = R { h: 0, w: 0 };

    for r in using {
        if cursor.w + r.w >= map.w || cursor.h + r.h >= map.h {
            return false;
        }

        for i in 0..r.h {
            for j in 0..r.w {
                if cursor.h + i < map.h && cursor.w + j < map.w {
                    cells[cursor.h + i][cursor.w + j] = true;
                }
            }
        }
        if cursor.w + r.w + 1 < map.w {
            cursor = R { h: cursor.h, w: cursor.w + r.w + 1 };
            continue;
        }
        if cursor.h + r.h + 1 < map.h {
            cursor = R { h: cursor.h + r.h + 1, w: cursor.w };
            continue;
        }
        break;
    }
    
    cells[map.h - 1][map.w - 1]
}
