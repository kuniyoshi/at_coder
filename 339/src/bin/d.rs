use std::io::{self, BufRead};
use std::collections::{VecDeque, HashMap};

#[derive(Eq, Hash, PartialEq, Clone, Copy, Debug)]
struct P {
    h: i32,
    w: i32,
}

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let mut cells: Vec<Vec<char>> = (0..n).map(|_| lines.next().unwrap().unwrap().chars().collect()).collect();

    let mut queue: VecDeque<((P, P), usize)> = VecDeque::new();
    let mut count: HashMap<(P, P), usize> = HashMap::new();

    queue.push_back((players(&mut cells), 0));

    let directions: Vec<P> = vec![P { h: 0, w: 1 }, P { h: 1, w: 0 }, P { h: 0, w: -1 }, P { h: -1, w: 0 }];

    while let Some(item) = queue.pop_front() {
        if count.contains_key(&item.0) {
            continue;
        }

        count.insert(item.0, item.1);

        for d in &directions {
            let next_players: (P, P) = (next_player(item.0.0.clone(), d.clone(), &cells), next_player(item.0.1.clone(), d.clone(), &cells));
            if count.contains_key(&next_players) {
                continue;
            }
            queue.push_back((next_players.clone(), item.1 + 1));
        }
    }

    let mut min: Option<usize> = None;

    for (key, value) in &count {
        if key.0 == key.1 {
            min = match min {
                None => Some(*value),
                Some(v) => Some(v.min(*value)),
            };
        }
    }

    match min {
        Some(v) => println!("{}", v),
        _ => println!("{}", -1),
    }
}

fn next_player(player: P, direction: P, cells: &Vec<Vec<char>>) -> P {
    let next = P { h: clamp(player.h + direction.h, cells.len()), w: clamp(player.w + direction.w, cells.len()) };

    if cells[next.h as usize][next.w as usize] != '#' {
        return next;
    }

    player
}

fn clamp(a: i32, n: usize) -> i32 {
    if a < 0 {
        return 0;
    }
    if a as usize >= n {
        return (n - 1) as i32;
    }
    a
}

fn players(cells: &mut Vec<Vec<char>>) -> (P, P) {
    let mut players: Vec<P> = Vec::new();

    for i in 0..cells.len() {
        for j in 0..cells.len() {
            if cells[i][j] == 'P' {
                players.push(P { h: i as i32, w: j as i32 });
                cells[i][j] = '.';
            }
        }
    }

    (players[0], players[1])
}