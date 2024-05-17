struct Index {
    c_passes: usize,
    a_passes: usize,
}

impl Index {
    fn passes(self: &Self) -> usize {
        self.c_passes + self.a_passes
    }

    fn new() -> Self {
        Self { c_passes: 0, a_passes: 0 }
    }

    fn inc_c(self: &Self) -> Self {
        Self { c_passes: self.c_passes + 1, a_passes: self.a_passes }
    }

    fn inc_a(self: &Self) -> Self {
        Self { c_passes: self.c_passes, a_passes: self.a_passes + 1 }
    }

    fn select(self: &Self, children: &Vec<usize>, adults: &Vec<usize>) -> bool {
        if self.c_passes >= children.len() && self.a_passes >= adults.len() {
            panic!();
        }
        if self.c_passes >= children.len() {
            return true;
        }
        if self.a_passes >= adults.len() {
            return false;
        }
    }
}

fn main() {
    proconio::input! {
        n: usize,
        s: proconio::marker::Chars,
        w: [usize; n],
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", s);

    #[cfg(debug_assertions)]
    eprintln!("{:?}", w);

    let mut children = Vec::new();
    let mut adults = Vec::new();

    for i in 0..n {
        if s[i] == '0' {
            children.push(w[i]);
        } else {
            adults.push(w[i]);
        }
    }

    children.sort();
    adults.sort();

    let mut cursor = Index::new();
    let mut wrongs = 0;

    let min = children.first().unwrap_or(&0).min(adults.first().unwrap_or(&0));

    for child in &children {
        if child >= min {
            wrongs += 1;
        }
    }

    for adult in &adults {
        if adult < min {
            wrongs += 1;
        }
    }

    while cursor.passes() < n {

    }
}
