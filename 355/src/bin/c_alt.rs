fn main() {
    proconio::input! {
        n: usize,
        t: usize,
        a: [usize; t],
    };

    let mut board = vec![vec![None; n]; n];

    for i in 0..t {
        let coord = coord(a[i], n);
        board[coord.0][coord.1] = Some(i + 1);
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", board);

    let mut result = None;

    for i in 0..n {
        result = min(max(&board[i]), result);
    }

    for j in 0..n {
        result = min(max(&(0..n).map(|i| board[i][j]).collect()), result);
    }

    result = min(max(&(0..n).map(|i| board[i][i]).collect()), result);

    result = min(max(&(0..n).map(|i| board[i][n - 1 - i]).collect()), result);

    match result {
        Some(value) => println!("{}", value),
        None => println!("{}", -1),
    };
}

fn min(a: Option<usize>, b: Option<usize>) -> Option<usize> {
    match (a, b) {
        (None, None) => None,
        (None, _) => b,
        (_, None) => a,
        (Some(a_value), Some(b_value)) => Some(a_value.min(b_value)),
    }
}

fn max(a: &Vec<Option<usize>>) -> Option<usize> {
    let mut min = None;
    for v in a {
        match (min, v) {
            (_, None) => return None,
            (None, Some(_)) => min = *v,
            (Some(min_value), Some(v_value)) => min = Some(min_value.max(*v_value)),
        };
    }
    min
}

fn coord(a: usize, n: usize) -> (usize, usize) {
    ((a - 1) / n, (a - 1) % n)
}
