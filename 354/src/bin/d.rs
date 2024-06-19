fn main() {
    proconio::input! {
        original_a: i64,
        original_b: i64,
        original_c: i64,
        original_d: i64,
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", (original_a, original_b, original_c, original_d));

    let (a, b, c, d) = translate(original_a, original_b, original_c, original_d);

    #[cfg(debug_assertions)]
    eprintln!("{:?}", (a, b, c, d));

    println!("{}", area(c, d) - area(a, b));
}

fn area(x: i64, y: i64) -> i64 {
    let row1 = vec![2, 1, 0, 1];
    let row2 = vec![1, 2, 1, 0];

    let r1 = (x / (row1.len() as i64)) * row1.iter().sum::<i64>() + row1.iter().take((x % (row1.len() as i64)) as usize).sum::<i64>();
    let r2 = (x / (row2.len() as i64)) * row2.iter().sum::<i64>() + row2.iter().take((x % (row2.len() as i64)) as usize).sum::<i64>();

    #[cfg(debug_assertions)]
    eprintln!("{:?}", (r1, r2));

    (r1 + r2) * (y / 2) + vec![r1, r2].iter().take((y % 2_i64) as usize).sum::<i64>()
}

fn translate(a: i64, b: i64, c: i64, d: i64) -> (i64, i64, i64, i64) {
    let x_move = if a < 0 { 4 * (a.abs() / 4 + 1) } else { -a / 4 };
    let y_move = if b < 0 { 2 * (b.abs() / 2 + 1) } else { -b / 2 };
    
    (a + x_move, b + y_move, c + x_move, d + y_move)
}