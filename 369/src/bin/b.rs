fn main() {
    proconio::input! {
        n: usize,
        inputs: [(i32, char); n],
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", (n, &inputs));

    let mut l = None;
    let mut r = None;

    let mut total = 0;

    for &(next, hand) in &inputs {
        match hand {
            'L' => match l {
                None => l = Some(next),
                Some(previous) => {
                    total += previous.abs_diff(next);
                    l = Some(next);
                },
            },
            'R' => match r {
                None => r = Some(next),
                Some(previous) => {
                    total += previous.abs_diff(next);
                    r = Some(next);
                }
            },
            _ => unreachable!()
        }
    }

    println!("{}", total);
}
