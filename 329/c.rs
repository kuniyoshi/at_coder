use fmt::Debug;
use std::fmt;
use std::io::{self, BufRead};
use std::str;
use std::cmp;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = read_one(&mut lines);
    let s: Vec<char> = lines.next().unwrap().unwrap().chars().collect();

    let mut buffers: Vec<usize> = vec!(0; 26);
    let mut maxes: Vec<usize> = vec!(0; 26);
    let mut previous: Option<char> = None;

    for i in 0..n {
        let index = ((s[i] as u8) - b'a') as usize;

        match previous {
            Some(c) if c == s[i] => {
                buffers[index] += 1;
                maxes[index] = cmp::max(buffers[index], maxes[index]);
            },
            Some(c) if c != s[i] => {
                buffers[((c as u8) - b'a') as usize] = 0;
                buffers[index] = 1;
                maxes[index] = cmp::max(buffers[index], maxes[index]);
            },
            None => {
                buffers[index] = 1;
                maxes[index] = cmp::max(buffers[index], maxes[index]);
            },
            _ => panic!("unknown pattern"),
        }
        previous = Some(s[i]);
        // buffers[s[i] - 'a'].push()
        // if buffer.len() == 0 {
        //     buffer.push(&s[i]);
        //     // set.insert(buffer.iter().map(|&c| c).collect::<String>());
        //     continue;
        // }

        // if buffer.last().unwrap() == &&s[i] {
        //     buffer.push(&s[i]);
        //     set.insert(buffer.iter().map(|&c| c).collect::<String>());
        //     continue;
        // }

        // if buffer.last().unwrap() != &&s[i] {
        //     buffer.clear();
        //     buffer.push(&s[i]);
        //     set.insert(buffer.iter().map(|&c| c).collect::<String>());
        //     continue;
        // }
    }
    // eprintln!("{:?}", maxes);

    println!("{}", maxes.iter().sum::<usize>());
}

fn read_one<A: str::FromStr>(lines: &mut io::Lines<io::StdinLock>) -> A
where
    A::Err: Debug + 'static,
{
    lines.next().unwrap().unwrap().parse().unwrap()
}
