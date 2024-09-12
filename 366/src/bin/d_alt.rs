struct Span {
    l: usize,
    r: usize,
}

fn main() {
    proconio::input! {
        n: usize,
        a: [[[u64; n]; n]; n],
        q: usize,
        lr: [[(usize, usize); 3]; q],
    };

    let mut acc = vec![vec![vec![0; n + 1]; n + 1]; n + 1];

    for i in 1..=n {
        for j in 1..=n {
            for k in 1..=n {
                acc[i][j][k] += a[i - 1][j - 1][k - 1];
            }
        }
    }

    for i in 1..=n {
        for j in 1..=n {
            for k in 1..=n {
                acc[i][j][k] += acc[i][j][k - 1];
            }
        }
    }

    for i in 1..=n {
        for j in 1..=n {
            for k in 1..=n {
                acc[i][j][k] += acc[i][j - 1][k];
            }
        }
    }

    for i in 1..=n {
        for j in 1..=n {
            for k in 1..=n {
                acc[i][j][k] += acc[i - 1][j][k];
            }
        }
    }

    for spans in &lr {
        let (k_l, k_r) = to_be_index(spans[0]);
        let (j_l, j_r) = to_be_index(spans[1]);
        let (i_l, i_r) = to_be_index(spans[2]);

        // #[cfg(debug_assertions)]
        // eprintln!("{:?}", ((k_l, k_r), (j_l, j_r), (i_l, i_r)));

        let area = area(&acc, Span { l: k_l, r: k_r }, Span { l: j_l, r: j_r }, Span { l: i_l, r: i_r });

        println!("{}", area);
    }
}

fn area(acc: &Vec<Vec<Vec<u64>>>, x: Span, y: Span, z: Span) -> u64 {
    let a = acc[z.r][y.r][x.r];
    let b = z.l.checked_sub(1).map(|zl| acc[zl][y.r][x.r]).unwrap_or(0);
}

fn to_be_index((a, b): (usize, usize)) -> (usize, usize) {
    (a - 1, b - 1)
}