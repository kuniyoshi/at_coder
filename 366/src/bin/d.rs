fn main() {
    proconio::input! {
        n: usize,
        a: [[[u64; n]; n]; n],
        q: usize,
        lr: [[(usize, usize); 3]; q],
    };

    // #[cfg(debug_assertions)]
    // eprintln!("{:?}", &a);

    // #[cfg(debug_assertions)]
    // eprintln!("{:?}", &lr);

    let mut accs = vec![vec![vec![0; n]; n]; n];

    for z in 0..n {
        for y in 0..n {
            accs[z][y][0] = a[0][y][z];

            for x in 1..n {
                accs[z][y][x] += accs[z][y][x - 1] + a[x][y][z];
            }
        }

        for y in 1..n {
            for x in 0..n {
                accs[z][y][x] += accs[z][y - 1][x];
            }
        }
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", &accs);

    for spans in &lr {
        let x_span = to_be_index(spans[0]);
        let y_span = to_be_index(spans[1]);
        let z_span = to_be_index(spans[2]);

        // #[cfg(debug_assertions)]
        // eprintln!("{:?}", (x_span, y_span, z_span));

        let mut total = 0;

        for i in z_span.0..=z_span.1 {
            total += sum(&accs[i], x_span, y_span);
        }

        println!("{}", total);
    }
}

fn sum(accs: &Vec<Vec<u64>>, x_span: (usize, usize), y_span: (usize, usize)) -> u64 {
    let both_max = accs[y_span.1][x_span.1];
    let both_min = match (x_span.0.checked_sub(1), y_span.0.checked_sub(1)) {
        (Some(x), Some(y)) => accs[y][x],
        _ => 0,
    };
    let x_max_y_min = y_span.0.checked_sub(1).map(|y| accs[y][x_span.1]).unwrap_or(0);
    let x_min_y_max = x_span.0.checked_sub(1).map(|x| accs[y_span.1][x]).unwrap_or(0);
    both_max + both_min - x_max_y_min - x_min_y_max
}

fn to_be_index((a, b): (usize, usize)) -> (usize, usize) {
    (a - 1, b - 1)
}