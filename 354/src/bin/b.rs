fn main() {
    proconio::input! {
        n: usize,
        users: [(String, usize); n],
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", users);

    let mut names = users.iter().map(|(name, _)| name.clone()).collect::<Vec<String>>();
    names.sort();

    let total = users.iter().map(|(_, rate)| rate).sum::<usize>();

    for (name, _) in &users {
        let id = names.iter().position(|v| v == name).unwrap();

        if id == total % n {
            println!("{}", name);
        }
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", users);
}
