use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let x: i64 = lines.next().unwrap().unwrap().parse().unwrap();

    let mod10 = x % 10;

    if mod10 == 0 {
        println!("{}", x / 10);
        return ();
    }

    if x >= 0 {
        println!("{}", (x / 10) + 1);
    } else {
        println!("{}", x / 10);
    }

    // TODO: 境界が 5 くらい？

    // if x < 0 {
    //     println!("{}", x / 10);
    // }
    // else {
    //     println!("{}", (x + 5) / 10);
    // }
}
