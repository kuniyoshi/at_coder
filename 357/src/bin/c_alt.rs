fn main() {
    proconio::input! {
        n: usize,
    };

    let mut result = vec![vec!['#'; 1]];

    for _ in 0..n {
        let cell = result;
        result = vec![vec!['.'; cell.len() * 3]; cell.len() * 3];

        for i in 0..result.len() {
            for j in 0..result[i].len() {
                if (i < cell.len() || 2 * cell.len() <= i)
                    || (j < cell.len() || 2 * cell.len() <= j)
                {
                    result[i][j] = cell[i % cell.len()][j % cell.len()];
                }
            }
        }
    }

    for i in 0..result.len() {
        for j in 0..result[i].len() {
            print!("{}", result[i][j]);
        }

        println!("");
    }
}
