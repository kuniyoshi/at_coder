struct P {
    index: usize,
    height: usize,
}

fn main() {
    proconio::input! {
        n: usize,
        mut heights: [usize; n],
    };

    heights.push(std::usize::MAX);
    let l = f(&heights);
    heights.pop();

    heights.reverse();
    heights.push(std::usize::MAX);
    let r = f(&heights);
    println!("{}", l.max(r));
}

fn f(heights: &Vec<usize>) -> usize {
    let mut mins = vec![heights.len() - 1; heights.len()];
    let mut stack: Vec<P> = Vec::new();

    for i in 0..heights.len() {
        while let Some(last) = stack.last() {
            if heights[i] < last.height {
                mins[last.index] = i;
                stack.pop();
            } else {
                break;
            }
        }
        stack.push(P { index: i, height: heights[i] });
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", mins);

    let mut max = 0;

    for i in 0..(heights.len() - 1) {
        max = max.max(heights[i] * (mins[i] - i));
    }

    max
}