use std::collections::{HashMap, HashSet};

fn main() {
    proconio::input! {
        n: usize,
        s: proconio::marker::Chars,
        t: proconio::marker::Chars,
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", (n, &s, &t));

    let mut using = HashSet::new();
    let mut cache = HashMap::new();
    let mut current = s.clone();
    current.push(' ');
    current.push(' ');
    let mut target = t.clone();
    target.push(' ');
    target.push(' ');

    let result = dfs(
        0,
        &mut current,
        None,
        &mut cache,
        &mut using,
        &target.iter().collect::<String>(),
    );

    match result {
        Some(r) => println!("{}", r),
        _ => println!("{}", -1),
    };
}

fn dfs(
    count: u64,
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
    eprintln!("{:?}", &s);

    let global_key = s.iter().collect::<String>();

    if global_key.eq(t) {
        cache.insert(global_key.clone(), Some(count));
        #[cfg(debug_assertions)]
        eprintln!("{:?}", (count, &global_key, &t));
        return Some(count);
    }

    let space = s
        .windows(2)
        .position(|chars| chars[0] == ' ' && chars[1] == ' ')
        .unwrap();

    let mut min = None;

    using.insert(global_key.clone());

    for i in 0..(s.len() - 1) {
        if s[i] != ' ' && s[i + 1] != ' ' {
            (s[space], s[space + 1], s[i], s[i + 1]) = (s[i], s[i + 1], s[space], s[space + 1]);
            let key = s.iter().collect::<String>();

            if !cache.contains_key(&key) {
                if !using.contains(&key) {
                    using.insert(key.clone());

                    if Some(key.clone()) != from {
                        min = optional_min(min, dfs(count + 1, s, from.clone(), cache, using, t));
                    }

                    using.remove(&key);
                }
            }

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
