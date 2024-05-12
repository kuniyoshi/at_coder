use std::collections::HashSet;

fn main() {
    proconio::input! {
        h: usize,
        w: usize,
        s: [proconio::marker::Chars; h],
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", s);

    let mut max = 0;
    let mut dof = vec![vec![None::<usize>; w]; h];

    for i in 0..h {
        for j in 0..w {
            if dof[i][j] != None {
                continue;
            }

            if s[i][j] == '#' {
                continue;
            }

            let mut queue = Vec::new();
            let mut visited = HashSet::new();
            queue.push((i, j));

            while let Some((u, v)) = queue.pop() {
                if visited.contains(&(u, v)) {
                    continue;
                }

                visited.insert((u, v));

                let mut can_move = true;

                if u > 0 && s[u - 1][v] == '#' {
                    can_move = false;
                }
                if u < h - 1 && s[u + 1][v] == '#' {
                    can_move = false;
                }
                if v > 0 && s[u][v - 1] == '#' {
                    can_move = false;
                }
                if v < w - 1 && s[u][v + 1] == '#' {
                    can_move = false;
                }

                if !can_move {
                    continue;
                }

                if u > 0 && !visited.contains(&(u - 1, v)) {
                    queue.push((u - 1, v));
                }
                if v > 0 && !visited.contains(&(u, v - 1)) {
                    queue.push((u, v - 1));
                }
                if u < h - 1 && !visited.contains(&(u + 1, v)) {
                    queue.push((u + 1, v));
                }
                if v < w - 1 && !visited.contains(&(u, v + 1)) {
                    queue.push((u, v + 1));
                }
            }

            let local_dof = visited.len();
            max = max.max(local_dof);

            for &(u, v) in &visited {
                dof[u][v] = Some(local_dof);
            }
        }
    }

    println!("{}", max);
}
