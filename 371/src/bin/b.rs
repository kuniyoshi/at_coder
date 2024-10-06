fn main() {
    proconio::input! {
        n: usize,
        m: usize,
        borns: [(usize, char); m],
    };

    let mut is_firsts = vec![true; n];

    for &(house, gender) in &borns {
        if gender == 'F' {
            println!("No");
            continue;
        }

        if is_firsts[house - 1] {
            println!("Yes");
            is_firsts[house - 1] = false;
        } else {
            println!("No");
        }
    }
}
