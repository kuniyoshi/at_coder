fn main() {
    proconio::input! {
        n: usize,
        x: usize,
        jumps: [(usize, usize); n],
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", jumps);

    let mut possibilities = vec![false; x + 1];
    possibilities[0] = true;

    for &(a, b) in &jumps {
        for i in (0..possibilities.len()).rev() {
            if possibilities[i] {
                if let Some(v) = possibilities.get_mut(i + a) {
                    *v = true;
                }
                if let Some(v) = possibilities.get_mut(i + b) {
                    *v = true;
                }
                possibilities[i] = false;
            }
        }
    }

    if possibilities[x] {
        println!("Yes");
    } else {
        println!("No");
    }
}