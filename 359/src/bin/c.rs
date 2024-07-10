fn main() {
    proconio::input! {
        mut sx: i64,
        mut sy: i64,
        mut tx: i64,
        mut ty: i64,
    };

    if (sx + sy % 2) == 1 {
        sx -= 1;
    }

    if (tx + ty % 2) == 1 {
        tx -= 1;
    }

    tx -= sx;
    ty -= sy;

    tx = tx.abs();
    ty = ty.abs();

    if ty > tx {
        println!("{}", ty);
    } else {
        println!("{}", (tx + ty) / 2);
    }
}
