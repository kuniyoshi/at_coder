fn main() {
    proconio::input! {
        mut a: proconio::marker::Chars,
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", &a);

    while a.len() > 0 && a.last().unwrap() == &'0' {
        a.pop();
    }

    if a.len() > 0 && a.last().unwrap() == &'.' {
        a.pop();
    }

    println!("{}", a.iter().collect::<String>());
}
