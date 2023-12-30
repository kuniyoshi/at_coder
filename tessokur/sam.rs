fn main() {
    let a: Vec<usize> = vec![1, 2, 5, 8, 15];
    println!("{}", 3.clamp_sub(4));
    // eprintln!("{:?}", upper_bound(2, &a));
}

// value 以下のもののうち、最大の添字を返す
fn upper_bound(value: usize, a: &Vec<usize>) -> Option<usize> {
    if a.len() == 0 {
        return None;
    }

    if &value > a.last().unwrap() {
        return Some(0);
    }

    if value == a[0] {
        return Some(0);
    }

    let mut ac: usize = a.len() - 1;
    let mut wa: usize = 0;

    while ac - wa > 1 {
        let wj = (ac + wa) / 2;
        if a[wj] <= value {
            ac = wj;
        } else {
            wa = wj;
        }
    }

    Some(ac)
}

// value 以上であるもののうち、最小の添え字を返す
fn lower_bound(value: usize, a: &Vec<usize>) -> Option<usize> {
    if a.len() == 0 {
        return None;
    }

    if &value > a.last().unwrap() {
        return None;
    }

    if a[0] >= value {
        return Some(0);
    }

    let mut ac: usize = a.len() - 1;
    let mut wa: usize = 0;

    while ac - wa > 1 {
        let wj = (ac + wa) / 2;
        if a[wj] >= value {
            ac = wj;
        }
        else {
            wa = wj;
        }
    }

    Some(ac)
}