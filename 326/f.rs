use fmt::Debug;
use std::cmp;
use std::fmt;
use std::io::{self, BufRead};
use std::str;
use std::collections::{HashMap};

enum Directoin {
    Right,
    Up,
    Left,
    Down,
}

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (_, x, y): (usize, i32, i32) = read_three(&mut lines);
    let a: Vec<i32> = read_list(&mut lines);

    let (odds, evens) = split_odd_even(&a);

    let can_odd_option = test(&odds, x);
    let can_even_option = test(&evens, y);

    match (can_odd_option, can_even_option) {
        (Some(can_odd), Some(can_even)) => {
            let mut is_positives: Vec<bool> = Vec::new();

            for i in 0..cmp::max(can_odd.len(), can_even.len()) {
                if i < can_even.len() {
                    is_positives.push(can_even[i]);
                }
                if i < can_odd.len() {
                    is_positives.push(can_odd[i]);
                }
            }

            println!("{}", yes_no(true));
            println!("{}", dump_directions(&is_positives));
        }
        (_, _) => println!("{}", yes_no(false)),
    };
}

fn dump_directions(is_positives: &Vec<bool>) -> String {
    let mut direction = Directoin::Right;
    let mut result: Vec<char> = Vec::new();
    // eprintln!("{}", "-".repeat(80));
    // eprintln!("{:?}", is_positives);

    for i in 0..is_positives.len() {
        match (direction, is_positives[i]) {
            (Directoin::Right, true) => {
                result.push('L');
                direction = Directoin::Up;
            }
            (Directoin::Right, false) => {
                result.push('R');
                direction = Directoin::Down;
            }
            (Directoin::Up, true) => {
                result.push('R');
                direction = Directoin::Right;
            }
            (Directoin::Up, false) => {
                result.push('L');
                direction = Directoin::Left;
            }
            (Directoin::Left, true) => {
                result.push('R');
                direction = Directoin::Up;
            }
            (Directoin::Left, false) => {
                result.push('L');
                direction = Directoin::Down;
            }
            (Directoin::Down, true) => {
                result.push('L');
                direction = Directoin::Right;
            }
            (Directoin::Down, false) => {
                result.push('R');
                direction = Directoin::Left;
            }
        }
    }

    result.iter().collect()
}

fn test(values: &Vec<i32>, to: i32) -> Option<Vec<bool>> {
    if values.len() == 0 {
        return if to == 0 { Some(Vec::new()) } else { None };
    }

    let mut head: HashMap<i32, i32> = HashMap::new();
    let mut tail: HashMap<i32, i32> = HashMap::new();

    for i in 0..2_i32.pow((values.len() / 2) as u32) {
        let mut value = 0_i32;
        for j in 0..(values.len() / 2) {
            if (i & 2 << j) > 0 {
                value += values[j];
            } else {
                value -= values[j];
            }
        }
        head.insert(value, i);
    }

    for i in 2_i32.pow((values.len() / 2) as u32)..(values.len() as i32) {
        let mut value = 0_i32;
        for j in (values.len() / 2)..(values.len()) {
            if (i & 2 << j) > 0 {
                value += values[(values.len()/2)+j];
            } else {
                value -= values[(values.len()/2)+j];
            }
        }
        head.insert(value, i);
    }

    for (key, value) in head.iter() {
        if let Some(v2) = tail.get(&(to - key)) {}
        if tail.contains_key(&(to - key)) {

        }
    }

    let abs_max = values.iter().map(|v| v.abs()).sum::<i32>() as usize;

    let mut dp = vec![vec!(false; abs_max * 2 + 1); values.len() + 1];
    dp[0][abs_max] = true;

    for i in 1..=values.len() {
        for j in 0..dp[i].len() {
            if !dp[i - 1][j] {
                continue;
            }

            let pj = j as i32 + values[i - 1];
            let nj = j as i32 - values[i - 1];

            if pj >= 0 && pj < dp[i].len() as i32 {
                dp[i][pj as usize] = true;
            }

            if nj >= 0 && nj < dp[i].len() as i32 {
                dp[i][nj as usize] = true;
            }
        }
    }

    if to < 0 && (to.abs() as usize) > abs_max {
        return None;
    }

    // eprintln!("{}", "-".repeat(80));
    // eprintln!("{:?}", dp);
    if !dp[values.len()][(abs_max as i32 + to) as usize] {
        return None;
    }

    let mut is_positives: Vec<bool> = Vec::new();
    let mut cursor = (abs_max as i32 + to) as usize;
    let len = dp[values.len()].len();

    for i in (1..=values.len()).rev() {
        let cand1 = cursor as i32 - values[i - 1];

        if cand1 >= 0 && (cand1 as usize) < len && dp[i - 1][cand1 as usize] {
            is_positives.push(true);
            cursor = cand1 as usize;
            continue;
        }

        let cand2 = cursor as i32 + values[i - 1];
        assert!(
            cand2 >= 0 && (cand2 as usize) < len && dp[i - 1][cand2 as usize],
            "should moved negative direction"
        );
        is_positives.push(false);
        cursor = cand2 as usize;
    }
    // eprintln!(
    //     "{:?}",
    //     is_positives.iter().rev().cloned().collect::<Vec<_>>()
    // );

    assert!(cursor == abs_max, "should back to the origin");

    Some(is_positives.iter().rev().cloned().collect())
}

fn yes_no(is_yes: bool) -> String {
    if is_yes {
        "Yes".to_string()
    } else {
        "No".to_string()
    }
}

fn split_odd_even(a: &Vec<i32>) -> (Vec<i32>, Vec<i32>) {
    let (mut odd, mut even) = (Vec::new(), Vec::new());

    for (index, value) in a.iter().enumerate() {
        if index % 2 == 0 {
            even.push(*value);
        } else {
            odd.push(*value);
        }
    }

    (odd, even)
}

fn read_three<A: str::FromStr, B: str::FromStr, C: str::FromStr>(
    lines: &mut io::Lines<io::StdinLock>,
) -> (A, B, C)
where
    A::Err: Debug + 'static,
    B::Err: Debug + 'static,
    C::Err: Debug + 'static,
{
    let line = lines.next().unwrap().unwrap();
    let mut parts = line.split_whitespace();
    let a: A = parts.next().unwrap().parse().unwrap();
    let b: B = parts.next().unwrap().parse().unwrap();
    let c: C = parts.next().unwrap().parse().unwrap();
    (a, b, c)
}

fn read_list<A: str::FromStr>(lines: &mut io::Lines<io::StdinLock>) -> Vec<A>
where
    A::Err: Debug + 'static,
{
    let line = lines.next().unwrap().unwrap();
    line.split_whitespace()
        .map(|s| s.parse().unwrap())
        .collect()
}
