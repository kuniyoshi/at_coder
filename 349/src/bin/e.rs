use std::collections::HashMap;

fn main() {
    proconio::input! {
        a: [[i64; 3]; 3],
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", a);

    let mut board = vec![vec![None::<bool>; 3]; 3];
    let mut cache = HashMap::new();

    let is_takahashi = dfs(true, &mut board, &a, &mut cache, 0, 0);
    println!("{}", if is_takahashi { "Takahashi" } else { "Aoki" });
}

fn hash(board: &Vec<Vec<Option<bool>>>) -> usize {
    let mut value = 0;

    for i in 0..3 {
        for j in 0..3 {
            match board[i][j] {
                Some(true) => {
                    // 0
                    value += 9 * i + 3 * j + 0;
                }
                Some(false) => {
                    // 1
                    value += 9 * i + 3 * j + 1;
                }
                None => {
                    // 2
                    value += 9 * i + 3 * j + 2;
                }
            }
        }
    }

    value
}

fn is_win(board: &Vec<Vec<Option<bool>>>, i: usize, j: usize) -> bool {
    let cursor = board[i][j];

    if board[i].iter().all(|v| v == &cursor) {
        return true;
    }

    if (0..3).map(|k| board[k][j]).all(|v| v == cursor) {
        return true;
    }

    if (0..3).map(|k| board[k][k]).all(|v| v == cursor) {
        return true;
    }

    if (0..3).map(|k| board[k][2 - k]).all(|v| v == cursor) {
        return true;
    }

    false
}

fn dfs(
    is_takahashi: bool,
    board: &mut Vec<Vec<Option<bool>>>,
    a: &Vec<Vec<i64>>,
    cache: &mut HashMap<usize, bool>,
    takahashi: i64,
    aoki: i64,
) -> bool {
    match cache.get(&hash(board)) {
        Some(is_takahashi) => return *is_takahashi,
        _ => (),
    };

    let mut did_try = false;
    let mut can_win = false;

    for i in 0..3 {
        for j in 0..3 {
            if board[i][j].is_some() {
                continue;
            }

            did_try = true;

            board[i][j] = Some(is_takahashi);

            if is_win(board, i, j) {
                cache.insert(hash(&board), is_takahashi);
                return is_takahashi;
            };

            let result = dfs(!is_takahashi, board, a, cache, takahashi + if is_takahashi { a[i][j]} else { 0}, aoki + if !is_takahashi { a[i][j]} else { 0});

            can_win = can_win || result;

            board[i][j] = None;
        }
    }

    if !did_try {
        cache.insert(hash(&board), takahashi > aoki); // 同点どうなるの？
        return takahashi > aoki;
    }

    can_win
}
