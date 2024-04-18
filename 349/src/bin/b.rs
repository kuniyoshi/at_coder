use std::collections::HashMap;

fn main() {
    proconio::input! {
        s: proconio::marker::Chars,
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", s);

    let mut count = HashMap::new();

    for c in &s {
        *count.entry(c).or_insert(0) += 1;
    }

    let mut saw = 0;
    let mut i = 1;

    loop {
        if saw >= s.len() {
            break;
        }

        let mut j = 0;

        for (_, value) in &count {
            if value == &i {
                j += 1;
            }
        }

        if j != 0 && j != 2 {
            println!("No");
            return ();
        }
        
        saw += j * i;
        i += 1;
    }

    println!("Yes");
}
