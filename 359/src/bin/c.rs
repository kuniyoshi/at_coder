fn main() {
    for i in -1..3 {
        for j in -1..3 {
            #[cfg(debug_assertions)]
            eprintln!("{:?} -> {:?}", (i, j), f(i, j));
        }
    }
}

fn f(x: i64, y: i64) -> (i64, i64) {
    if x + y % 2 == 0 {
        (x / 2, y)
    } else {
        ((x + 1) / 2, y)
    }
}