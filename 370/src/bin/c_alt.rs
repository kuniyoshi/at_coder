use std::cmp::Ordering;

fn main() {
    proconio::input! {
        mut s: proconio::marker::Chars,
        t: proconio::marker::Chars,
    };
    
    let differs = s.iter().zip(t.iter()).filter(|(a, b)| a != b).map(|_| 1).sum::<usize>();

    println!("{}", differs);

    for _ in 0..differs {
        let mut min = None;

        for i in 0..s.len() {
            if s[i] == t[i] {
                continue;
            }

            let mut new = s.clone();
            new[i] = t[i];

            match &min {
                None => min = Some(new.clone()),
                Some(min_value) => match compare(&min_value, &new) {
                    Ordering::Less => (),
                    Ordering::Equal => (),
                    Ordering::Greater => {
                        min = Some(new.clone());
                    },
                },
            }
        }

        if let Some(min_value) = &min {
            for j in 0..s.len() {
                print!("{}", min_value[j]);
            }

            println!("");

            s = min_value.clone();
        } else {
            unreachable!();
        }
    }
}

fn compare(a: &[char], b: &[char]) -> Ordering {
    for (x, y) in a.iter().zip(b.iter()) {
        match x.cmp(y) {
            Ordering::Equal => continue,
            other => return other,
        }
    }
    Ordering::Equal
}
