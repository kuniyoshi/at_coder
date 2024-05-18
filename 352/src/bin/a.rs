fn main() {
    proconio::input! {
        _: usize,
        x: usize,
        y: usize,
        z: usize,
    };

    if x.min(y) <= z && z <= x.max(y) {
        println!("Yes");
    } else {
        println!("No");
    }
}
