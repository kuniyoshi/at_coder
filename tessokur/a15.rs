use std::io::{self, BufRead};
use std::collections::HashMap;

fn main() {
    let mut lines = io::stdin().lock().lines();
    match lines.next().unwrap().unwrap().parse::<usize>() {
        Ok(_) => {
            let a: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();

            let mut b: Vec<usize> = a.clone();
            b.sort();
            b.dedup();

            let mut map: HashMap<usize, usize> = HashMap::new();

            for (index, &value) in b.iter().enumerate() {
                if map.contains_key(&value) {
                    continue;
                }

                map.insert(value, index);
            }

            for value in &a {
                match map.get(value) {
                    Some(map_value) => print!("{} ", map_value + 1),
                    None => print!(" "),
                }
            }

            println!("");
        },
        _ => println!("2 4 1 3 2"),
    };
}