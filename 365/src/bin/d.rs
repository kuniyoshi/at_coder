struct Rps {
    r: Option<u64>,
    p: Option<u64>,
    s: Option<u64>,
}

// R のときグー、
// P のときパー、
// S のときチョキです。
impl Rps {
    fn max(self: &Self) -> Option<u64> {
        [self.r, self.p, self.s].iter().filter_map(|&x| x).max()
    }

    fn iter_max(a: Option<u64>, b: Option<u64>) -> Option<u64> {
        [a, b].iter().filter_map(|&x| x).max()
    }

    fn plus_one(a: Option<u64>) -> Option<u64> {
        match a {
            Some(value) => Some(value + 1),
            _ => None,
        }
    }

    fn update(self: &Self, char: char) -> Self {
        match char {
            'R' => Self {
                r: Self::iter_max(self.p, self.s),
                p: Self::iter_max(Self::plus_one(self.r), Self::plus_one(self.s)),
                s: None,
            },
            'P' => Self {
                r: None,
                p: Self::iter_max(self.r, self.s),
                s: Self::iter_max(Self::plus_one(self.p), Self::plus_one(self.r)),
            },
            'S' => Self {
                r: Self::iter_max(Self::plus_one(self.p), Self::plus_one(self.s)),
                p: None,
                s: Self::iter_max(self.r, self.p),
            },
            _ => unreachable!(),
        }
    }
}

fn main() {
    proconio::input! {
        n: usize,
        s: proconio::marker::Chars,
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", (n, &s));

    let mut rps = Rps {
        r: Some(0),
        p: Some(0),
        s: Some(0),
    };

    for c in &s {
        rps = rps.update(*c);
    }

    println!("{}", rps.max().unwrap());
}
