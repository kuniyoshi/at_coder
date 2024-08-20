/**
 * 123123123... / 123
 * 100100100...
 * 10^2 + 10^4 + 10^6 + ...
 */
fn main() {
    proconio::input! {
        n: usize,
    };

    // for i in 0..5 {
    //     #[cfg(debug_assertions)]
    //     eprintln!("{:?}", (i, f(n, i)));
    // }

    let unit = 998244353;

    let mut result = 0;

    // f(5, 2) + f(5, 0)
    for i in 0..64 {
        if (n & (1 << i)) > 0 {
            result += f(n, i);
            result %= unit;
        }
    }

    println!("{}", result);
}

// f(5, 0) -> 5
// f(5, 1) -> 55
// f(5, 2) -> 5555
// f(5, 3) -> 55555555
fn f(n: usize, i: usize) -> usize {
    if i == 0 {
        return n;
    }
    let unit = 998244353;
    let r = f(n, i - 1) % unit;

    (r * 10_u64.pow(r.to_string().len() as u32) as usize + r) % unit
}
