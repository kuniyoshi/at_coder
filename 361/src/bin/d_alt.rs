use std::collections::{HashSet, VecDeque};

fn main() {
    proconio::input! {
        _: usize,
        mut s: proconio::marker::Chars,
        mut t: proconio::marker::Chars,
    };

    s.push('.');
    s.push('.');
    t.push('.');
    t.push('.');

    let mut queue = VecDeque::new();
    let mut visited = HashSet::new();

    queue.push_back((0, s.clone()));

    while let Some((cost, state)) = queue.pop_front() {
        if state.eq(&t) {
            println!("{}", cost);
            return;
        }

        if visited.contains(&hash(&state)) {
            continue;
        }

        visited.insert(hash(&state));

        // #[cfg(debug_assertions)]
        // eprintln!("{:?}", (hash(&state), &state));

        let space = state
            .windows(2)
            .enumerate()
            .position(|(_, c)| c[0] == '.' && c[1] == '.')
            .unwrap();

        for (index, chars) in state.windows(2).enumerate() {
            if chars[0] != '.' && chars[1] != '.' {
                let new_state = swap_board(&state, index, space);
                // #[cfg(debug_assertions)]
                // eprintln!("{:?}", ("new_state", &new_state, hash(&new_state)));

                if !visited.contains(&hash(&new_state)) {
                    queue.push_back((cost + 1, new_state));
                }
            }
        }
    }

    println!("{}", -1);
}

fn swap_board(chars: &Vec<char>, a: usize, b: usize) -> Vec<char> {
    let mut result = chars.clone();

    result.swap(a, b);
    result.swap(a + 1, b + 1);

    result
}

fn hash(chars: &Vec<char>) -> u64 {
    let mut result = 0;

    for i in 0..chars.len() {
        let value = match chars[i] {
            'B' => 0,
            'W' => 1,
            '.' => 2,
            _ => unreachable!(),
        };
        result = result * 3 + value;
    }

    result
}
