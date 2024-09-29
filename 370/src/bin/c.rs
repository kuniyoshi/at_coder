use std::collections::BinaryHeap;

fn main() {
    proconio::input! {
        s: proconio::marker::Chars,
        t: proconio::marker::Chars,
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", (&s, &t));

    let mut result = s.clone();

    let mut differences = BinaryHeap::new();

    for i in 0..s.len() {
        if s[i] < t[i] {
            differences.push((0, i as i32));
        } else if s[i] > t[i] {
            differences.push((1, -(i as i32)));
        }
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", &differences);

    println!("{}", differences.len());

    while let Some((sign, position)) = differences.pop() {
        if sign == 0 {
            result[position as usize] = t[position as usize];
        } else {
            result[(-position) as usize] = t[(-position) as usize];
        }

        for i in 0..result.len() {
            print!("{}", result[i]);
        }

        println!("");
    }
}
