struct V2 {
    x: i32,
    y: i32,
}

impl V2 {
    fn new(x: i32, y: i32) -> Self {
        Self { x, y }
    }

    fn dot(self: &Self, other: &Self) -> i32 {
        self.x * other.x + self.y * other.y
    }

    fn direction(a: &Self, b: &Self) -> Self {
        Self {
            x: b.x - a.x,
            y: b.y - a.y,
        }
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

    let a = V2::new(a1, a2);
    let b = V2::new(b1, b2);
    let c = V2::new(c1, c2);

    if V2::direction(&a, &b).dot(&V2::direction(&a, &c)) == 0
        || V2::direction(&b, &a).dot(&V2::direction(&b, &c)) == 0
        || V2::direction(&c, &a).dot(&V2::direction(&c, &b)) == 0
    {
        println!("Yes");
    } else {
        println!("No");
    }
}
