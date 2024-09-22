use std::collections::HashSet;

fn main() {
    proconio::input! {
        a: i64,
        b: i64,
    };
    let mut set = HashSet::new();
    let diff = a.max(b) - a.min(b);
    set.insert(a.max(b) + diff);
    set.insert(a.min(b) - diff);
    if diff % 2 == 0 {
        set.insert(a.min(b) + diff / 2);
    }
    println!("{}", set.len());
}
