fn main() {
    proconio::input! {
        n: usize,
        a: [u64; n],
    };

    let mut odd = None::<u64>;
    let mut even = None::<u64>;

    for i in 0..a.len() {
        #[cfg(debug_assertions)]
        eprintln!("{:?}", (odd, even));

        let next_odd = match (odd, even) {
            (Some(odd_value), Some(even_value)) => Some(odd_value.max(even_value + a[i])),
            (Some(_), None) => odd,
            (None, Some(_)) => unreachable!(),
            _ => Some(a[i]),
        };
        let next_even = match (odd, even) {
            (Some(odd_value), Some(even_value)) => Some(even_value.max(odd_value + a[i] * 2)),
            (Some(odd_value), None) => Some(odd_value + a[i] * 2),
            (None, Some(_)) => even,
            _ => None,
        };
        odd = next_odd;
        even = next_even;

        #[cfg(debug_assertions)]
        eprintln!("-> {:?}", (odd, even));
    }

    let max = match (odd, even) {
        (Some(odd_value), Some(even_value)) => odd_value.max(even_value),
        (Some(odd_vlaue), None) => odd_vlaue,
        (None, Some(even_vlaue)) => even_vlaue,
        _ => 0,
    };

    println!("{}", max);
}
