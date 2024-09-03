use std::collections::HashMap;

#[derive(Eq, PartialEq, Debug, Hash, Clone)]
struct State {
    sweetness: u64,
    saltiness: u64,
}

impl State {
    fn new(sweetness: u64, saltiness: u64) -> Self {
        Self {
            sweetness,
            saltiness,
        }
    }

    fn add(self: &Self, sweetness: u64, saltiness: u64) -> Self {
        Self {
            sweetness: self.sweetness + sweetness,
            saltiness: self.saltiness + saltiness,
        }
    }

    fn test(self: &Self, other: &Self) -> bool {
        other.sweetness <= self.sweetness && other.saltiness <= self.saltiness
    }
}

fn main() {
    proconio::input! {
        n: usize,
        x: u64,
        y: u64,
        dishes: [(u64, u64); n],
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", (n, x, y, &dishes));

    let mut dp = HashMap::new();
    dp.insert(State::new(0, 0), 0);

    let limit = State::new(x, y);

    for &(sweetness, saltiness) in &dishes {
        let mut next = dp.clone();
        let mut keys = Vec::new();

        for key in dp.keys() {
            keys.push(key);
        }

        for state in &keys {
            if !limit.test(&state) {
                continue;
            }

            let new_state = state.add(sweetness, saltiness);
            let count = dp.get(state).unwrap() + 1;

            match next.get(&new_state) {
                Some(c) if c < &count => {
                    next.insert(new_state, count);
                }
                None => {
                    next.insert(new_state, count);
                }
                _ => (),
            }
        }

        dp = next;
    }

    // #[cfg(debug_assertions)]
    // eprintln!("{:?}", dp);

    let max = dp.iter().max_by(|(_, a), (_, b)| a.cmp(b)).unwrap().1;

    println!("{}", max);
}
