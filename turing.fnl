;;; Turing Patterns

(local turing {})

(fn turing.noise []
  (let [c (* (math.random) 0.03)]
    (if (> (math.random) 0.5)
      c
      (- 0 c))))

(fn turing.build-grid [rows columns]
  (fcollect [i 1 rows]
    (fcollect [j 1 columns]
      (+ 1 (turing.noise)))))

(fn turing.rows [grid]
  (length grid))

(fn turing.columns [grid]
  (length (. grid 1)))

(fn turing.cell [grid column row]
  (let [c (if (> column (turing.columns grid)) 1 column)
        c (if (< c 1) (turing.columns grid) c)
        r (if (> row (turing.rows grid)) 1 row)
        r (if (< r 1) (turing.rows grid) r)]
    (. (. grid r) c)))

(fn turing.neighbourhood [grid column row]
  (+ (turing.cell grid column (- row 1))
     (turing.cell grid column (+ row 1))
     (turing.cell grid (- column 1) row)
     (turing.cell grid (+ column 1) row)))

(fn turing.update [grid]
  (each [i row (ipairs grid)]
    (each [j cell (ipairs row)]
      (print cell))))

turing
