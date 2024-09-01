use std::collections::HashMap;

fn main() {
    proconio::input! { q: usize };

    let mut map = HashMap::new();

    for _ in 0..q {
        proconio::input! { operator: u64 };

        match operator {
            1 => {
                proconio::input! { x: u64 };
                *map.entry(x).or_insert(0) += 1;
            }
            2 => {
                proconio::input! { x: u64 };
                *map.entry(x).or_insert(0) -= 1;

                if map.get(&x).unwrap() == &0 {
                    map.remove(&x);
                }
            }
            3 => {
                println!("{}", map.len());
            }
            _ => unreachable!(),
        };
    }
}
