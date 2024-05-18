fn main() {
    proconio::input! {
        n: usize,
        p: [(usize, usize); n],
    };

    let diff = p.iter().map(|ab| ab.1 - ab.0).max().unwrap_or(0);
    let top = p.iter().position(|ab| ab.1 - ab.0 == diff).unwrap_or(0);

    let sholders = p.iter().enumerate().filter(|(i, _)| i != &top).map(|(_, ab)| ab.0).sum::<usize>();

    println!("{}", sholders + p[top].1);
}
