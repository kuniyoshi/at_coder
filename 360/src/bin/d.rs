fn main() {
    proconio::input! {
        n: usize,
        t: u64,
        directions: proconio::marker::Chars,
        initial_points: [i64; n],
    };

    let mut a: Vec<_> = (0..n).filter(|i| directions[*i] == '0').map(|i| initial_points[i]).collect();
    let mut b: Vec<_> = (0..n).filter(|i| directions[*i] == '1').map(|i| initial_points[i]).collect();

    a.sort();
    b.sort();

    #[cfg(debug_assertions)]
    eprintln!("{:?}", a);
    #[cfg(debug_assertions)]
    eprintln!("{:?}", b);

    let mut total = 0_u64;

    for v in &a {
        let tv = v - (2 * t) as i64; // t 秒後の位置
        let o1 = bin_less(&b, *v); // v より小さいものの添え字を返す
        let o2 = bin_more(&b, tv - 1); // t 秒後の v とすれ違うものの添え字を返す

        #[cfg(debug_assertions)]
        eprintln!("{:?}", (o1, o2));

        match (o1, o2) {
            // (None, None) => continue,
            // (Some(_), None) => continue,
            // (None, Some(_)) => continue,
            (Some(i), Some(j)) if b[i] >= tv && b[j] >= tv => total += ((i as i64) - (j as i64)).abs() as u64 + 1,
            _ => continue,
        };
    }

    // for v in &b {
    //     let tv = v + (2 * t) as i64; // t 秒後の位置
    //     let o1 = bin_more(&a, *v); // v より小さいものの添え字を返す
    //     let o2 = bin_less(&a, tv + 1); // t 秒後の v とすれ違うものの添え字を返す

    //     match (o1, o2) {
    //         // (None, None) => continue,
    //         // (Some(_), None) => continue,
    //         // (None, Some(_)) => continue,
    //         (Some(i), Some(j)) if a[i] <= tv && a[j] <= tv => total += ((i as i64) - (j as i64)).abs() as u64 + 1,
    //         _ => continue,
    //     };
    // }

    println!("{}", total);
    // println!("{}", total / 2);
}

// t より大きいものを探す、添え字を返す
fn bin_more(items: &Vec<i64>, t: i64) -> Option<usize> {
    if items.last().unwrap() < &t {
        return None;
    }

    if items[0] <= t {
        return Some(0);
    }

    let mut ac = items.len() - 1;
    let mut wa = 0;

    while ac - wa > 1 {
        let wj = (ac + wa) / 2;
        if items[wj] > t {
            ac = wj;
        } else {
            wa = wj;
        }
    }

    Some(ac)
}

// t より小さいものを探す、添え字を返す
fn bin_less(items: &Vec<i64>, t: i64) -> Option<usize> {
    if items[0] >= t {
        return None;
    }

    if items.last().unwrap() < &t {
        return Some(items.len() - 1);
    }

    let mut ac = 0;
    let mut wa = items.len() - 1;

    while wa - ac > 1 {
        let wj = (ac + wa) / 2;
        if items[wj] < t {
            ac = wj;
        } else {
            wa = wj;
        }
    }

    Some(ac)
}