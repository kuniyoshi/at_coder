#[derive(Debug)]
#[derive(Clone)]
struct P {
    x: i64,
    y: i64,
    z: i64,
}

impl P {
    fn new(a: i64, b: i64, c: i64) -> Self {
        P { x: a, y: b, z: c }
    }

    fn length(self: &Self) -> f64 {
        match (self.x > 0, self.y > 0, self.z > 0) {
            (true, true, true) => ((self.x.pow(2) + self.y.pow(2) + self.z.pow(2)) as f64).sqrt(),
            _ => 0f64,
        }
    }

    fn slide(self: &Self, other: &Self) -> Self {
        Self {
            x: self.x - other.x,
            y: self.y - other.y,
            z: self.z - other.z,
        }
    }

    fn volume(self: &Self) -> f64 {
        match (self.x > 0, self.y > 0, self.z > 0) {
            (true, true, true) => (self.x * self.y * self.z) as f64,
            _ => 0f64,
        }
    }
}

#[derive(Debug)]
#[derive(Clone)]
struct Cube {
    a: P,
    b: P,
}

impl Cube {
    fn new(a: P, b: P) -> Self {
        Cube { a, b }
    }

    fn min(self: &Self) -> P {
        if self.a.length() < self.b.length() {
            self.a.clone()
        } else {
            self.b.clone()
        }
    }

    fn max(self: &Self) -> P {
        if self.a.length() >= self.b.length() {
            self.a.clone()
        } else {
            self.b.clone()
        }
    }

    fn slide(self: &Self, p: P) -> Self {
        Self::new(self.a.slide(&p), self.b.slide(&p))
    }

    fn volume(self: &Self) -> f64 {
        self.max().volume()
    }
}

fn main() {
    proconio::input! {
        a: i64,
        b: i64,
        c: i64,
        
        d: i64,
        e: i64,
        f: i64,
       
        g: i64,
        h: i64,
        i: i64,

        j: i64,
        k: i64,
        l: i64,
    };

    let mut a = Cube::new(P::new(a, b, c), P::new(d, e, f));
    let mut b = Cube::new(P::new(g, h, i), P::new(j, k, l));

    if a.max().length() > b.max().length() {
        b = b.slide(a.min());

        #[cfg(debug_assertions)]
        eprintln!("if {:?}", (a, b.clone())); // TODO: なんで clone ?

        if b.volume() > 0f64 {
            println!("Yes");
        } else {
            println!("No");
        }
    } else {
        a = a.slide(b.min());

        #[cfg(debug_assertions)]
        eprintln!("else {:?}", (a.clone(), b));

        if a.volume() > 0f64 {
            println!("Yes");
        } else {
            println!("No");
        }
    }
}
