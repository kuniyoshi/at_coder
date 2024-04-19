use std::collections::HashSet;

fn main() {
    proconio::input! {
        n: usize,
    };

    // 1, 11, 111, 1111
    // 1 + 11 + 111
    // 1111 + 1 + 11
    // 1111 + 1 + 111
    //　ひとつ増える度に、 C( |S| - 1, 2) パターン増える
    // |S| = 3 のとき |T| = 1 種類
    // |S| = 4 のとき |T| = t_1 + C(t_1, 2)

    // let mut s = 3;
    // let mut t = 1;

    // loop {
    //     t += comb2(s);
    //     s += 1;

    //     #[cfg(debug_assertions)]
    //     eprintln!("({}, {})", s, t);

    //     if t >= 333 {
    //         break;
    //     }
    // }

    let mut set = HashSet::new();

    for i in 1..=14 {
        for j in 1..=i {
            for k in 1..=j {
                set.insert(ru(k) + ru(j) + ru(i));
            }
        }
    }

    let mut values: Vec<_> = set.iter().collect();
    values.sort();

    println!("{}", values[n - 1]);
}

// 0 -> 1
// 1 -> 1
// 2 -> 11
fn ru(a: usize) -> usize {
    let mut result = 1;
    for _ in 1..a {
        result *= 10;
        result += 1;
    }
    result
}

// fn comb2(a: usize) -> usize {
//     a * (a - 1) / 2
// }
