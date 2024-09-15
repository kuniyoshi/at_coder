use std::collections::VecDeque;

fn main() {
    proconio::input! {
        n: usize,
        h: [i64; n],
    };

    let mut queue: VecDeque<i64> = h.into_iter().collect();
    let mut t = 0;

    while let Some(hp) = queue.pop_front() {
        t = attacks(hp, t);
    }

    println!("{}", t);
}

fn power(t: u64) -> i64 {
    match t % 3 {
        0 => 3,
        _ => 1,
    }
}

fn attacks(mut hp: i64, mut t: u64) -> u64 {
    // #[cfg(debug_assertions)]
    // eprintln!("{:?}", (hp, t));

    t += (hp as u64 / 5) * 3;
    hp %= 5;

    while hp > 0 {
        t += 1;
        hp -= power(t);
    }

    t
}
