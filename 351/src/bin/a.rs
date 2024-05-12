fn main() {
    proconio::input! {
        a: [usize; 9],
        b: [usize; 8],
    };

    let takahashi = a.iter().sum::<usize>();
    let aoki = b.iter().sum::<usize>();

    let p = takahashi - aoki + 1;

    println!("{}", p);
}
