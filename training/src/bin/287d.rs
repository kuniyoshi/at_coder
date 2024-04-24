fn main() {
    proconio::input! {
        s: proconio::marker::Chars,
        t: proconio::marker::Chars,
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", s);

    #[cfg(debug_assertions)]
    eprintln!("{:?}", t);

    // a?c
    // b?
    //   [F, T]
    //      [T, T]
    // 0:    T  T
    // 1: F     T
    // 2: F  T

    let mut matches_l = vec![false; t.len() + 1];
    let mut matches_r = vec![false; t.len() + 1];

    for i in 0..t.len() {
        matches_l[i] = is_match(s[i], t[i]);
    }

    for i in 1..t.len() {
        matches_l[i] = matches_l[i - 1] && matches_l[i];
    }

    for i in 0..t.len() {
        matches_r[i + 1] = is_match(s[s.len() - t.len() + i], t[i]);
    }

    matches_r.reverse();

    for i in 1..t.len() {
        matches_r[i] = matches_r[i - 1] && matches_r[i];
    }

    matches_r.reverse();

    #[cfg(debug_assertions)]
    eprintln!("{:?}", matches_l);

    #[cfg(debug_assertions)]
    eprintln!("{:?}", matches_r);

    for i in 0..(t.len() + 1) {
        let l = if i > 0 { Some(i - 1) } else { None::<usize> };
        let r = if i < t.len() { Some(t.len() - i) } else { None::<usize> };

        match (l, r) {
            (Some(l_index), Some(r_index)) => if matches_l[l_index] && matches_r[r_index] {
                println!("Yes");
            } else {
                println!("No");
            },
            (Some(l_index), None) => if matches_l[l_index] {
                println!("Yes");
            } else {
                println!("No");
            },
            (None, Some(r_index)) => if matches_r[r_index] {
                println!("Yes");
            } else {
                println!("No");
            },
            (_, _) => unreachable!()
        }
    }
}

fn is_match(a: char, b: char) -> bool {
    match (a, b) {
        ('?', _) => true,
        (_, '?') => true,
        (_, _) => a == b,
    }
}
