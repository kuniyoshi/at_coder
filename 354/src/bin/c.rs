fn main() {
    proconio::input! {
        n: usize,
        base_cards: [(usize, usize); n],
    };

    let mut cards: Vec<_> = base_cards
        .iter()
        .enumerate()
        .map(|(index, (strength, cost))| (strength, index, cost))
        .collect();
    cards.sort();
    cards.reverse();

    #[cfg(debug_assertions)]
    eprintln!("{:?}", cards);

    let mut last_cost = 1_000_000_001;
    let mut results = Vec::new();

    for i in 0..n {
        if cards[i].2 > &last_cost {
            continue;
        }

        results.push(cards[i].1 + 1);
        last_cost = *cards[i].2;
    }

    results.sort();

    println!("{}", results.len());

    for i in 0..results.len() {
        print!("{} ", results[i]);
    }

    println!("");
}
