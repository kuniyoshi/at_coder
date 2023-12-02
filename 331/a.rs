use fmt::Debug;
use std::collections::HashMap;
use std::fmt;
use std::io::{self, BufRead};
use std::str;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (months_per_year, days_per_month): (usize, usize) = read_two(&mut lines);
    let (today_year, today_month, today_day): (usize, usize, usize) = read_three(&mut lines);

    let day = if today_day + 1 > days_per_month { 1 } else { today_day + 1 };
    let month_1 = if day == 1 { today_month + 1 } else { today_month };
    let month = if month_1 > months_per_year { 1 } else { today_month };
    let year = if month == 1 { today_year + 1 } else { today_year };

    println!("{} {} {}", year, month, day);

    // let months = today_year * months_per_year + today_month;
    // let days = months * days_per_month + today_day;

    // // 2023 11 30
    // // -> (2023 * 12 * 30 + 11 * 30 + 30) = 728640
    // // -> 728641
    // // -> day: 1
    // // -> month: 
    // let tomorrow = days + 1;

    // let t_day = if tomorrow % days_per_month == 0 { days_per_month } else { tomorrow % days_per_month };
    // let t_month = if (tomorrow / days_per_month) % months_per_year == 0 { months_per_year } else { (tomorrow / days_per_month) % months_per_year };
    // let t_year = tomorrow / (days_per_month * months_per_year);

    // println!("{} {} {}", t_year, t_month, t_day);
}

fn yes_no(is_yes: bool) -> &'static str {
    if is_yes {
        "Yes"
    } else {
        "No"
    }
}

fn read_list<A: str::FromStr>(lines: &mut io::Lines<io::StdinLock>) -> Vec<A>
where
    A::Err: Debug + 'static,
{
    let line = lines.next().unwrap().unwrap();
    line.split_whitespace()
        .map(|s| s.parse().unwrap())
        .collect()
}

fn read_four<A: str::FromStr, B: str::FromStr, C: str::FromStr, D: str::FromStr>(
    lines: &mut io::Lines<io::StdinLock>,
) -> (A, B, C, D)
where
    A::Err: Debug + 'static,
    B::Err: Debug + 'static,
    C::Err: Debug + 'static,
    D::Err: Debug + 'static,
{
    let line = lines.next().unwrap().unwrap();
    let mut parts = line.split_whitespace();
    let a: A = parts.next().unwrap().parse().unwrap();
    let b: B = parts.next().unwrap().parse().unwrap();
    let c: C = parts.next().unwrap().parse().unwrap();
    let d: D = parts.next().unwrap().parse().unwrap();
    (a, b, c, d)
}

fn read_three<A: str::FromStr, B: str::FromStr, C: str::FromStr>(
    lines: &mut io::Lines<io::StdinLock>,
) -> (A, B, C)
where
    A::Err: Debug + 'static,
    B::Err: Debug + 'static,
    C::Err: Debug + 'static,
{
    let line = lines.next().unwrap().unwrap();
    let mut parts = line.split_whitespace();
    let a: A = parts.next().unwrap().parse().unwrap();
    let b: B = parts.next().unwrap().parse().unwrap();
    let c: C = parts.next().unwrap().parse().unwrap();
    (a, b, c)
}

fn read_two<A: str::FromStr, B: str::FromStr>(lines: &mut io::Lines<io::StdinLock>) -> (A, B)
where
    A::Err: Debug + 'static,
    B::Err: Debug + 'static,
{
    let line = lines.next().unwrap().unwrap();
    let mut parts = line.split_whitespace();
    let a: A = parts.next().unwrap().parse().unwrap();
    let b: B = parts.next().unwrap().parse().unwrap();
    (a, b)
}

fn read_one<A: str::FromStr>(lines: &mut io::Lines<io::StdinLock>) -> A
where
    A::Err: Debug + 'static,
{
    lines.next().unwrap().unwrap().parse().unwrap()
}
