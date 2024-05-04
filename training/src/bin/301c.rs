use std::collections::{HashMap, HashSet};

fn main() {
    proconio::input! {
        s: proconio::marker::Chars,
        t: proconio::marker::Chars,
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", s);

    #[cfg(debug_assertions)]
    eprintln!("{:?}", t);

    let mut t_count = HashMap::new();

    for i in 0..t.len() {
        *t_count.entry(t[i]).or_insert(0) += 1;
    }

    let mut s_count = HashMap::new();

    for i in 0..s.len() {
        *s_count.entry(s[i]).or_insert(0) += 1;
    }

    println!("{}", if test(&mut s_count, &mut t_count) { "Yes" } else { "No" });
}

fn test(s_count: &mut HashMap<char, usize>, t_count: &mut HashMap<char, usize>) -> bool {
    let mut keep = HashSet::new();
    keep.insert('a');
    keep.insert('t');
    keep.insert('c');
    keep.insert('o');
    keep.insert('d');
    keep.insert('e');
    keep.insert('r');

    for (key, count) in s_count.iter().filter(|(k, _)| !keep.contains(k)) {
        if key == &'@' {
            continue;
        }
        match t_count.get(key) {
            Some(t_value) if t_value != count => return false,
            None => return false,
            _ => (),
        }
        t_count.remove(key);
    }

    for (key, count) in t_count.iter().filter(|(k, _)| !keep.contains(k)) {
        if key == &'@' {
            continue;
        }
        match s_count.get(key) {
            Some(s_value) if s_value != count => return false,
            None => return false,
            _ => (),
        }
        s_count.remove(key);
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", s_count);

    #[cfg(debug_assertions)]
    eprintln!("{:?}", t_count);

    let mut s_at = s_count.get(&'@').map_or(0, |v| *v) as i64;
    let mut t_at = t_count.get(&'@').map_or(0, |v| *v) as i64;

    for c in &keep {
        let s = s_count.get(c).map_or(0, |v| *v) as i64;
        let t = t_count.get(c).map_or(0, |v| *v) as i64;
        match s.cmp(&t) {
            std::cmp::Ordering::Less => s_at -= t - s,
            std::cmp::Ordering::Equal => (),
            std::cmp::Ordering::Greater => t_at -= s - t,
        };
    }

    s_at >= 0 && s_at == t_at
}