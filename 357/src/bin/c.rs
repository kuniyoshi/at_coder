fn size(n: usize) -> usize {
    3_u64.pow(n as u32) as usize
}

fn main() {
    proconio::input! {
        n: usize,
    };

    if n == 0 {
        println!("#");
        return;
    }

    let mut result = vec![vec!['#'; size(n)]; size(n)];

    for i in 0..3 {
        for j in 0..3 {
            if i == 1 && j == 1 {
                for k in 0..size(n - 1) {
                    for l in 0..size(n - 1) {
                        result[i * size(n - 1) + k][j * size(n - 1) + l] = '.';
                    }
                }
            } else {
                carpet(&mut result, i * size(n - 1), j * size(n - 1), n - 1);
            }
        }
    }

    for i in 0..size(n) {
        for j in 0..size(n) {
            print!("{}", result[i][j]);
        }

        println!("");
    }
}

fn carpet(result: &mut Vec<Vec<char>>, row: usize, col: usize, n: usize) -> () {
    if n == 0 {
        result[row][col] = '#';
        return;
    }

    for i in 0..3 {
        for j in 0..3 {
            if i == 1 && j == 1 {
                for k in 0..size(n - 1) {
                    for l in 0..size(n - 1) {
                        result[row + i * size(n - 1) + k][col + j * size(n - 1) + l] = '.';
                    }
                }
            } else {
                carpet(result, row + i * size(n - 1), col + j * size(n - 1), n - 1);
            }
        }
    }
}