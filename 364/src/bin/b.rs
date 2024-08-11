fn main() {
    proconio::input! {
        h: usize,
        w: usize,
        mut si: usize,
        mut sj: usize,
        cells: [proconio::marker::Chars; h],
        walks: proconio::marker::Chars,
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", (h, w, (si, sj)));

    #[cfg(debug_assertions)]
    eprintln!("{:?}", cells);

    #[cfg(debug_assertions)]
    eprintln!("{:?}", walks);

    si -= 1;
    sj -= 1;

    for direction in walks {
        match direction {
            'L' => {
                let ni = si;
                let nj = sj.checked_sub(1).unwrap_or(sj);
                if cells.get(ni).and_then(|v| v.get(nj)) == Some(&'.') {
                    (si, sj) = (ni, nj);
                }
            },
            'R' => {
                let ni = si;
                let nj = sj + 1;
                if cells.get(ni).and_then(|v| v.get(nj)) == Some(&'.') {
                    (si, sj) = (ni, nj);
                }
            },
            'U' => {
                let ni = si.checked_sub(1).unwrap_or(si);
                let nj = sj;
                if cells.get(ni).and_then(|v| v.get(nj)) == Some(&'.') {
                    (si, sj) = (ni, nj);
                }
            },
            'D' => {
                let ni = si + 1;
                let nj = sj;
                if cells.get(ni).and_then(|v| v.get(nj)) == Some(&'.') {
                    (si, sj) = (ni, nj);
                }
            },
            _ => unreachable!(),
        };
    }

    println!("{} {}", si + 1, sj + 1);
}
