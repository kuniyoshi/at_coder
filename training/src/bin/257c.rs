struct Index {
    c_passes: usize,
    a_passes: usize,
}

impl Index {
    fn passes(self: &Self) -> usize {
        self.c_passes + self.a_passes
    }

    fn new() -> Self {
        Self {
            c_passes: 0,
            a_passes: 0,
        }
    }

    fn inc_c(self: &Self) -> Self {
        Self {
            c_passes: self.c_passes + 1,
            a_passes: self.a_passes,
        }
    }

    fn inc_a(self: &Self) -> Self {
        Self {
            c_passes: self.c_passes,
            a_passes: self.a_passes + 1,
        }
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
        if adults[self.a_passes] < children[self.c_passes] {
            return true;
        }
        false
    }
}

fn main() {
    proconio::input! {
        n: usize,
        s: proconio::marker::Chars,
        w: [usize; n],
    };

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

    let min = children.iter().chain(adults.iter()).min().copied().unwrap();

    #[cfg(debug_assertions)]
    eprintln!("{:?}", children);

    #[cfg(debug_assertions)]
    eprintln!("{:?}", adults);

    #[cfg(debug_assertions)]
    eprintln!("min: {:?}", min);

    for child in &children {
        if child >= &min {
            wrongs += 1;
        }
    }

    for adult in &adults {
        if adult < &min {
            wrongs += 1;
        }
    }

    let mut result = n - wrongs;

    while cursor.passes() < n {
        #[cfg(debug_assertions)]
        eprintln!("wrongs: {:?}", wrongs);

        let value = match cursor.select(&children, &adults) {
            true => adults[cursor.a_passes],
            false => children[cursor.c_passes],
        };

        for i in cursor.a_passes..adults.len() {
            if adults[i] != value {
                break;
            }
            cursor = cursor.inc_a();
            wrongs += 1;
        }

        for i in cursor.c_passes..children.len() {
            if children[i] != value {
                break;
            }
            cursor = cursor.inc_c();
            wrongs -= 1;
        }

        result = result.max(n - wrongs)
    }

    println!("{}", result);
}
