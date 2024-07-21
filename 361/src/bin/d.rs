use std::collections::{HashMap, HashSet};

fn main() {
    proconio::input! {
        n: usize,
        s: proconio::marker::Chars,
        t: proconio::marker::Chars,
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", (n, s.clone(), t.clone())); // TODO: なんで move するの？

    let mut used = HashSet::new();
    let mut cache = HashMap::new();
    let mut current = s.clone();
    current.push(' ');
    current.push(' ');
    let mut target = t.clone();
    target.push(' ');
    target.push(' ');

    let result = dfs(
        &mut current,
        None,
        &mut cache,
        &mut used,
        &target.iter().collect::<String>(),
    );

    match result {
        Some(r) => println!("{}", r),
        _ => println!("{}", -1),
    };
}

fn dfs(
    s: &mut Vec<char>,
    from: Option<String>,
    cache: &mut HashMap<String, Option<u64>>,
    using: &mut HashSet<String>,
    t: &String,
) -> Option<u64> {
    if let Some(cache_value) = cache.get(&s.iter().collect::<String>()) {
        return *cache_value;
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", s);

    let space = s
        .windows(2)
        .position(|chars| chars[0] == ' ' && chars[1] == ' ')
        .unwrap();

    let mut min = None;
    let global_key = s.iter().collect::<String>();

    using.insert(global_key.clone());

    for i in 0..(s.len() - 1) {
        if s[i] != ' ' && s[i + 1] != ' ' {
            (s[space], s[space + 1], s[i], s[i + 1]) = (s[i], s[i + 1], s[space], s[space + 1]);
            let key = s.iter().collect::<String>();

            using.insert(key.clone());

            if Some(key.clone()) != from {
                min = optional_min(min, dfs(s, from.clone(), cache, using, t));
            }

            using.remove(&key);

            (s[space], s[space + 1], s[i], s[i + 1]) = (s[i], s[i + 1], s[space], s[space + 1]);
        }
    }

    using.remove(&global_key);
    cache.insert(s.iter().collect(), min);

    min
}

fn optional_min(a: Option<u64>, b: Option<u64>) -> Option<u64> {
    match (a, b) {
        (Some(a_v), Some(b_v)) => Some(a_v.min(b_v)),
        (None, _) => b,
        _ => a,
    }
}
