use std::collections::HashMap;


fn main() {
    proconio::input! {
        n: usize,
        m: usize,
        a: [usize; n],
        b: [usize; m],
    };

    let mut origin = HashMap::new();

    for a_value in &a {
        origin.insert(a_value, 1);
    }

    for b_value in &b {
        origin.insert(b_value, 2);
    }

    let mut c = Vec::new();
    c.extend(a.iter().copied());
    c.extend(b.iter().copied());
    c.sort();

    let mut last = 0;

    for i in 0..c.len() {
        if last == 1 && origin.get(&c[i]).unwrap() == &1 {
            println!("Yes");
            return ();
        }
        last = *origin.get(&c[i]).unwrap();
    }

    println!("No");
}
