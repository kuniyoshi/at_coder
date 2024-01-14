use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, a, b): (usize, usize, usize) = {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1], list[2])
    };

    let mut is_wins: Vec<bool> = vec![false; n + 1];
    is_wins[a] = true;
    
    for i in a..=n {
        if i >= b {
            is_wins[i] = !is_wins[i - a] || !is_wins[i - b];
        } else {
            is_wins[i] = !is_wins[i - a];
        }
    }

    // 8 2 3
    // 0 1 2 3 4 5 6 7 8
    // L L W W W L L W W
    // - 2 (A) 未満は負け状態
    // - 

    println!("{}", if is_wins[n] { "First" } else { "Second" });
    #[cfg(debug_assertions)]
    eprintln!("{:?}", is_wins);
}