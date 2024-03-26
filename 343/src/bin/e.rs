use std::io::{self, BufRead};

#[derive(Debug)]
struct C {
    x: i32,
    y: i32,
    z: i32,
}

impl C {
    fn new(x: i32, y: i32, z: i32) -> Self {
        C { x, y, z }
    }

    fn to_string(&self) -> String {
        format!("{} {} {}", self.x, self.y, self.z)
    }

    fn iter(from: i32, count: i32) -> impl Iterator<Item = C> {
        (from..(from + count)).flat_map(move |a| {
            (from..(from + count)).flat_map(move |b| {
                (from..(from + count)).map(move |c| C::new(a, b, c))
            })
        })
    }
}

#[derive(Debug)]
struct V {
    a: usize,
    b: usize,
    c: usize,
}

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (v1, v2, v3) = {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1], list[2])
    };
    let v = V { a: v1, b: v2, c: v3 };

    let c1 = C { x: 0, y: 0, z: 0 };

    for c2 in C::iter(-7, 15) {
        for c3 in C::iter(-7, 15) {
            if test(&c1, &c2, &c3, &v) {
                println!("Yes");
                println!("{} {} {}", c1.to_string(), c2.to_string(), c3.to_string());
                return ();
            }
        }
    }

    println!("No");


    // -100                              0                                100
    //                 -------
    //                  -------
    //                   -------
    // 3: 5, 2: 2, 1: 2
    // 200 x 
    // 0 - 7, 7 - 14, 14 - 21
}

fn should_be(a: &C, b: &C, c: &C) -> bool {
    return false
    // a.to_string() == "0 0 0" && b.to_string() == "0 6 0" && c.to_string() == "6 0 0"
}

fn test(a: &C, b: &C, c: &C, v: &V) -> bool {
    let should_be = should_be(a, b, c);
    if should_be {
        #[cfg(debug_assertions)]
        eprintln!("{:?}", a);

        #[cfg(debug_assertions)]
        eprintln!("{:?}", b);

        #[cfg(debug_assertions)]
        eprintln!("{:?}", c);

        #[cfg(debug_assertions)]
        eprintln!("{:?}", v);
    }

    let x3 = len3(a.x, b.x, c.x);
    let y3 = len3(a.y, b.y, c.y);
    let z3 = len3(a.z, b.z, c.z);

    let triple = x3 * y3 * z3;

    if should_be {
        println!("triple({}, {}, {}): {}", x3, y3, z3, triple);
    }

    if triple != v.c {
        return false;
    }

    let x12 = len2(a.x, b.x);
    let y12 = len2(a.y, b.y);
    let z12 = len2(a.z, b.z);

    let x23 = len2(c.x, b.x);
    let y23 = len2(c.y, b.y);
    let z23 = len2(c.z, b.z);

    let x13 = len2(c.x, a.x);
    let y13 = len2(c.y, a.y);
    let z13 = len2(c.z, a.z);

    let doubles = x12 * y12 * z12 + x23 * y23 * z23 + x13 * y13 * z13 - 3 * triple;

    if should_be {
        println!("doubles: {}", doubles);
    }

    if doubles != v.b {
        return false;
    }

    let whole = 7 * 7 * 7 * 3;
    let single = whole - 3 * triple - 2 * doubles;

    if should_be {
        println!("single: {}", single);
    }

    single == v.a

}

fn len2(a: i32, b: i32) -> usize {
    let min = a.min(b);
    let max = a.max(b);
    // min, min + 7, max, max + 7
    if min + 7 > max {
        return (min + 7 - max) as usize;
    }
    0
}

fn len3(a: i32, b: i32, c: i32) -> usize {
    let mut abc = vec![a, b, c];
    abc.sort();

    len2(abc[0], abc[2])
}