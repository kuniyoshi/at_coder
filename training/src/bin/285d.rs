use std::{collections::{HashMap, HashSet}, io::{self, BufRead}};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let translations: Vec<(String, String)> = (0..n).map(|_| {
        let list: Vec<String> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.to_string()).collect();
        (list[0].clone(), list[1].clone())
    }).collect();

    let mut map = HashMap::new();

    for (from, to) in &translations {
        map.insert(from, to);
    }

    let mut whole_visited = HashSet::new();

    for (v, _) in &translations {
        if whole_visited.contains(v) {
            continue;
        }

        let mut visited = HashSet::new();

        visited.insert(v);
        let mut from = v;

        while let Some(&to) = map.get(from) {
           if visited.contains(to) {
                #[cfg(debug_assertions)]
                eprintln!("{}", to);

                println!("No");
                return ();
           }
           visited.insert(to);
           from = to;
        }

        for &used in visited.iter() {
            whole_visited.insert(used);
        }
    }

    println!("Yes");
}
