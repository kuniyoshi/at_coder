struct P {
    x: i32,
    y: i32,
}

impl P {
    fn new(x: i32, y: i32) -> Self {
        Self { x, y }
    }

    fn length(self: &Self, other: &Self) -> i32 {
        (other.x - self.x).pow(2) + (other.y - self.y).pow(2)
    }
}

fn main() {
    proconio::input! {
        a1: i32,
        a2: i32,
        b1: i32,
        b2: i32,
        c1: i32,
        c2: i32,
    };

    if is_right_triangle(P::new(a1, a2), P::new(b1, b2), P::new(c1, c2))
        || is_right_triangle(P::new(a1, a2), P::new(c1, c2), P::new(b1, b2))
        || is_right_triangle(P::new(c1, c2), P::new(b1, b2), P::new(a1, a2))
    {
        println!("Yes");
    } else {
        println!("No");
    }
}

fn is_right_triangle(a: P, b: P, c: P) -> bool {
    a.length(&b) == b.length(&c) + c.length(&a)
}
