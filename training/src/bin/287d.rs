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

    for ti in 0..t.len() {
        // 3 - 2 + ti -> 1, 2
        let si = s.len() - t.len() + ti;
        matches_r[ti + 1] = is_match(s[si], t[ti]);
    }

    for ri in (1..t.len()).rev() {
        matches_r[ri] = matches_r[ri + 1] && matches_r[ri];
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", matches_l);

    #[cfg(debug_assertions)]
    eprintln!("{:?}", matches_r);

    if matches_r[matches_r.len() - t.len()] {
        println!("Yes");
    } else {
        println!("No");
    }

    for i in 0..(t.len() - 1) {
        let l = i;
        let r = matches_r.len() - t.len() + 1 + i;

        if matches_l[l] && matches_r[r] {
            println!("Yes");
        } else {
            println!("No");
        }
    }

    if matches_l[t.len() - 1] {
        println!("Yes");
    } else {
        println!("No");
    }

}

fn is_match(a: char, b: char) -> bool {
    match (a, b) {
        ('?', _) => true,
        (_, '?') => true,
        (_, _) => a == b,
    }
}
