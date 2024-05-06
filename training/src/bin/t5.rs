use std::collections::HashMap;

fn main() {
    proconio::input! {
        n: usize,
        buys: [(usize, usize); n],
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", buys);

    let mut buyers = HashMap::new();

    for &(who, what) in &buys {
        buyers.entry(what).or_insert_with(Vec::new).push(who);
    }

    for (key, people) in &buyers {
        print!("{}: ", key);

        for who in people {
            print!("{} ", who);
        }

        println!("");
    }
}
