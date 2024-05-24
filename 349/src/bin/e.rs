fn main() {
    proconio::input! {
        a: [[i64; 3]; 3],
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", a);

    let mut board = vec![vec![None::<bool>; 3]; 3];

    let is_takahashi = dfs(&mut board, &a);
    println!("{}", if is_takahashi { "Takahashi" } else { "Aoki" });
}

fn is_win(board: &Vec<Vec<Option<bool>>>, a: &Vec<Vec<i64>>) -> Option<bool> {
    if board.iter().flat_map(|v| v.iter()).any(|v| v.is_none()) {
        return None;
    }

    if board.iter().any(|cols| cols.iter().all(|v| v.unwrap())) {
        return Some(true);
    }

    if (0..3).any(|j| (0..3).all(|i| board[i][j].unwrap())) {
        return Some(true);
    }

    if (0..3).all(|i| board[i][i].unwrap()) {
        return Some(true);
    }

    if (0..3).all(|i| board[i][2 - i].unwrap()) {
        return Some(true);
    }

    let mut me = 0;
    let mut other = 0;

    for i in 0..3 {
        for j in 0..3 {
            if board[i][j].unwrap() {
                me += a[i][j];
            } else {
                other += a[i][j];
            }
        }
    }

    Some(me > other)
}

fn flip(board: &mut Vec<Vec<Option<bool>>>) {
    for i in 0..3 {
        for j in 0..3 {
            board[i][j] = match board[i][j] {
                Some(true) => Some(false),
                Some(false) => Some(true),
                _ => None,
            };
        }
    }
}

fn dfs(board: &mut Vec<Vec<Option<bool>>>, a: &Vec<Vec<i64>>) -> bool {
    for i in 0..3 {
        for j in 0..3 {
            if board[i][j].is_some() {
                continue;
            }

            board[i][j] = Some(true);

            let r = is_win(board, a);

            if r.is_some() {
                return r.unwrap();
            }

            flip(board);
            let result = dfs(board, a);
            flip(board);

            board[i][j] = None;

            if !result {
                return true;
            }
        }
    }

    false
}
