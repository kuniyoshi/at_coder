use std::collections::HashSet;

fn main() {
    proconio::input! {
        a: usize,
        b: usize,
    };

    let mut set = HashSet::new();
    set.insert(1);
    set.insert(2);
    set.insert(3);

    set.remove(&a);
    set.remove(&b);

    if set.len() == 1 {
        println!("{}", set.iter().find(|v| *v > &0).unwrap());
    } else {
        println!("-1");
    }
}
