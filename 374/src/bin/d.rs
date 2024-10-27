fn main() {
    proconio::input! {
        n: usize,
        s: u64,
        t: u64,
        lines: [((i64, i64), (i64, i64)); n],
    };

    let mut orders: Vec<_> = (0..n).collect();
    let mut min = None;

    loop {
        // ビットが 1 なら a, b に s で移動して、c, d に t で移動する
        for i in 0..(2_i32.pow(n as u32) as usize) {
            let mut total = 0_f64;
            let mut previous = (0, 0);

            for j in 0..n {
                let line = lines[orders[j]];

                if ((1 << orders[j]) & i) > 0 {
                    total += duration(previous, line.0, s);
                    previous = line.0;
                    total += duration(previous, line.1, t);
                    previous = line.1;
                } else {
                    total += duration(previous, line.1, s);
                    previous = line.1;
                    total += duration(previous, line.0, t);
                    previous = line.0;
                }
            }

            min = select_min(total, min);
        }

        if !next_permutation(&mut orders) {
            break;
        }
    }

    println!("{}", min.unwrap());
}

fn duration(from: (i64, i64), to: (i64, i64), s: u64) -> f64 {
    let distance = (from.0 - to.0).pow(2) + (from.1 - to.1).pow(2);
    (distance as f64).sqrt() / s as f64
}

fn select_min(a: f64, b: Option<f64>) -> Option<f64> {
    match b {
        Some(b_value) => Some(b_value.min(a)),
        _ => Some(a),
    }
}

fn next_permutation(arr: &mut Vec<usize>) -> bool {
    let mut i = arr.len() - 1;
    while i > 0 && arr[i - 1] >= arr[i] {
        i -= 1;
    }

    if i == 0 {
        return false;
    }

    let mut j = arr.len() - 1;
    while arr[j] <= arr[i - 1] {
        j -= 1;
    }

    arr.swap(i - 1, j);

    arr[i..].reverse();

    true
}
