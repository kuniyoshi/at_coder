use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (_, a, b): (usize, usize, usize) = {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1], list[2])
    };
    let d: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();

    let min = d.iter().map(|v| (v - 1) % (a + b)).min().unwrap();
    let mut days: Vec<_> = d.iter().map(|v| (v - 1) % (a + b)).map(|v| v - min).collect();
    days.sort();
    days.dedup();

    if days.iter().max().unwrap() < &a {
        println!("Yes");
        return ();
    }


    let max = days.iter().map(|v| {

    }).max

    #[cfg(debug_assertions)]
    eprintln!("{:?}", min);

    #[cfg(debug_assertions)]
    eprintln!("{:?}", days);
}
