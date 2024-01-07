use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, q): (usize, usize) = {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1])
    };
    let queries: Vec<String> = (0..q).map(|_| { lines.next().unwrap().unwrap().split_whitespace().collect() }).collect();

    #[cfg(debug_assertions)]
    eprintln!("{:?}", queries);

    let mut positions: Vec<(i32, i32)> = Vec::new();

    for i in (1..=n).rev() {
        positions.push((i as i32, 0));
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", positions);

    for q in &queries {
        let query: Vec<_> = q.chars().collect();

        match query[0] {
            '1' => {
                let top = positions.last().unwrap();
                match query[1] {
                    'R' => positions.push((top.0 + 1, top.1)),
                    'L' => positions.push((top.0 - 1, top.1)),
                    'U' => positions.push((top.0, top.1 + 1)),
                    'D' => positions.push((top.0, top.1 - 1)),
                    _ => panic!("Unknown operation"),
                }
            },
            '2' => {
                let num_str: String = query[1..].iter().collect();
                let p: usize = num_str.parse().unwrap();
                let answer = positions[positions.len() - 1 - (p - 1)];
                println!("{} {}", answer.0, answer.1);
            },
            _ => panic!("Unknown query"),
        }
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", positions);
}