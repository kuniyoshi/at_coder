fn main() {
    proconio::input! {
        h: usize,
        w: usize,
        y: usize,
        a: [[u64; w]; h],
    };

    let mut hights = Vec::new();

    for i in 0..h {
        for j in 0..w {
            hights.push(
                min(&[
                    a.get(i.wrapping_sub(1))
                        .and_then(|v| v.get(j.wrapping_sub(1)).copied()),
                    a.get(i.wrapping_sub(1)).and_then(|v| v.get(j).copied()),
                    a.get(i.wrapping_sub(1)).and_then(|v| v.get(j + 1).copied()),
                    a.get(i).and_then(|v| v.get(j.wrapping_sub(1)).copied()),
                    a.get(i).and_then(|v| v.get(j).copied()),
                    a.get(i).and_then(|v| v.get(j + 1).copied()),
                    a.get(i + 1).and_then(|v| v.get(j.wrapping_sub(1)).copied()),
                    a.get(i + 1).and_then(|v| v.get(j).copied()),
                    a.get(i + 1).and_then(|v| v.get(j + 1).copied()),
                ])
                .unwrap_or(0),
            );
        }
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", hights);

    // #[cfg(debug_assertions)]
    // eprintln!("{:?}", a);
}

fn min(values: &[Option<u64>]) -> Option<u64> {
    values.iter().filter_map(|&x| x).min()
}
