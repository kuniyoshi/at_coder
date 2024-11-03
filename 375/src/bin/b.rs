fn main() {
    proconio::input! {
        n: usize,
        mut points: [(i64, i64); n],
    };

    points.push((0, 0));

    #[cfg(debug_assertions)]
    eprintln!("{:?}", &points);

    let mut cost = 0_f64;
    let mut current = (0, 0);

    for point in &points {
        cost += (((current.0 - point.0).pow(2) + (current.1 - point.1).pow(2)) as f64).sqrt();
        current = *point;
    }

    println!("{}", cost);
}
