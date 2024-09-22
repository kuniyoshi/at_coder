use std::collections::HashMap;

fn main() {
    proconio::input! {
        n: usize,
        mut a: [u64; n],
    };

    a.sort();
    
    let mut count = HashMap::new();

    for i in &a {
        *count.entry(i).or_insert(0) += 1;
    }

    let mut values: Vec<_> = count.keys().collect();
    values.sort();

    let mut cursor = 0;
    let mut grand_total = count.values().map(|v| v * (v - 1)).sum::<u64>();

    while cursor < values.len() - 1{
        let mut diff = None;
        let mut total = 0;

        for i in (cursor + 1)..values.len() {
            let value = values[i - 1];
            let next = values[i];
            match diff {
                None => {
                    diff = Some(*next - *value);
                    total = *count.get(next).unwrap();
                },
                Some(diff_value) if diff_value == *next - *value => {
                    total += count.get(next).unwrap() * total;
                },
                _ => break,
            };

            cursor += 1;
        }

        grand_total += total;
    }

    println!("{}", grand_total);
}
