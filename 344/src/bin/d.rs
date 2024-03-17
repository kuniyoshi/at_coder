use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let t: Vec<char> = lines.next().unwrap().unwrap().chars().collect();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let bags: Vec<Vec<Vec<char>>> = (0..n).map(|_| {
        let line = lines.next().unwrap().unwrap();
        line.split_whitespace().skip(1).map(|s| s.chars().collect::<Vec<char>>()).collect()
    }).collect();

    // i 文字目まで一致しているときのかかる金額の最低値
    let mut global_dp: Vec<Option<usize>> = vec![None; t.len() + 1];
    global_dp[0] = Some(0);

    for bag in &bags { // 100
        let mut local_dp = Vec::new();

        for item in bag { // 10
            let mut dp = global_dp.clone();

            for i in 0..dp.len() { // 100
                match dp[i] {
                    Some(v) => {
                        if test(&t, i, &item) {
                            dp[i + item.len()] = update(dp[i + item.len()], v + 1);
                        }
                    },
                    None => (),
                }
            }

            local_dp.push(dp);
        }

        for i in 0..global_dp.len() {
            for dp in &local_dp {
                global_dp[i] = update2(global_dp[i], dp[i]);
            }
        }
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", global_dp);

    match global_dp.last().unwrap() {
        Some(v) => println!("{}", v),
        _ => println!("{}", -1),
    }
}

fn update2(global: Option<usize>, local: Option<usize>) -> Option<usize> {
    match global {
        Some(global_value) => {
            match local {
                Some(local_value) => {
                    if local_value < global_value {
                        Some(local_value)
                    }
                    else {
                        Some(global_value)
                    }
                }
                None => global,
            }
        }
        None => local,
    }
}

fn update(current: Option<usize>, new_value: usize) -> Option<usize> {
    match current {
        Some(v) if v <= new_value => current,
        _ => Some(new_value),
    }
}

fn test(t: &Vec<char>, p: usize, u: &Vec<char>) -> bool {
    if p + u.len() > t.len() {
        return false;
    }

    for i in 0..u.len() {
        if u[i] != t[i + p] {
            return false;
        }
    }

    true
}