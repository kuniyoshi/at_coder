struct Direction {
    value: char,
}

impl Direction {
    fn new(value: char) -> Self {
        assert!(vec!['L','R','U','D'].iter().any(|v| v == &value));
        Self { value }
    }

    fn coordinate(self: &Self, i: usize, j: usize) -> Option<(usize, usize)> {
        match self.value {
            'L' => j.checked_sub(1).map(|nj| Some((i, nj))).unwrap_or(None),
            'R' => Some((i, j + 1)),
            'U' => i.checked_sub(1).map(|ni| Some((ni, j))).unwrap_or(None),
            'D' => Some((i + 1, j)),
            _ => unreachable!("{} is not valid value", self.value),
        }
    }
}

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

    let directions: Vec<_> = walks.iter().map(|d| Direction::new(*d)).collect();

    for direction in directions {
        match direction.coordinate(si, sj) {
            Some((ni, nj)) if cells.get(ni).and_then(|v| v.get(nj)) == Some(&'.') => (si, sj) = (ni, nj),
            _ => continue,
        };
    }

    println!("{} {}", si + 1, sj + 1);
}
