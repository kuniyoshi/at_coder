use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();

    let mut max = 1;

    for i in 1..10_000_000 {
        if i * i * i > n {
            break;
        }

        if is_kaibun(i * i * i) {
            max = i * i * i;
        }
    }

    println!("{}", max);
}

fn is_kaibun(a: usize) -> bool {
    a.to_string().chars().eq(a.to_string().chars().rev())
}
