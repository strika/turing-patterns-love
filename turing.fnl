;;; Turing Patterns

(local turing {})

(local neighbourhood-coordinates [[-1 0] [1 0] [0 -1] [0 1]])

; Parameters
(local a 1)
(local b -1)
(local c 2)
(local d -1.5)
(local h 1)
(local k 1)
(local du 0.0001) ; diffusion constant of u
(local dv 0.0006) ; diffusion constant of v

(fn turing.noise []
  (let [c (* (math.random) 0.03)]
    (if (> (math.random) 0.5)
      c
      (- 0 c))))

(fn turing.build-grid-with-noise [columns rows]
  (fcollect [i 1 rows]
    (fcollect [j 1 columns]
      (+ 1 (turing.noise)))))

(fn turing.build-grid [columns rows]
  (fcollect [i 1 rows]
    (fcollect [j 1 columns]
      1)))

(fn turing.rows [grid]
  (length grid))

(fn turing.columns [grid]
  (length (. grid 1)))

(fn turing.cell [grid column row]
  (let [c (if (> column (turing.columns grid)) 1 column)
        c (if (< c 1) (turing.columns grid) c)
        r (if (> row (turing.rows grid)) 1 row)
        r (if (< r 1) (turing.rows grid) r)]
    (. grid r c)))

(fn turing.update-cell [grid column row value]
  (tset (. grid row) column value))

(fn turing.neighbourhood [grid column row]
  (accumulate [sum 0
               _ [dr dc] (ipairs neighbourhood-coordinates)]
    (+ sum (turing.cell grid (+ column dc) (+ row dr)))))

(fn turing.update [u-grid v-grid dt]
  (local rows (turing.rows u-grid))
  (local columns (turing.columns u-grid))
  (local new-u-grid (turing.build-grid columns rows))
  (local new-v-grid (turing.build-grid columns rows))
  (local dh (/ 1 rows))
  (for [i 1 rows]
    (for [j 1 columns]
      (let [uc (turing.cell u-grid j i)
            vc (turing.cell v-grid j i)
            u-neighbourhood (turing.neighbourhood u-grid j i)
            v-neighbourhood (turing.neighbourhood v-grid j i)
            u-lap (/ (- u-neighbourhood (* 4 uc)) (* dh dh))
            v-lap (/ (- v-neighbourhood (* 4 vc)) (* dh dh))
            new-uc (+ uc (* (+ (* a (- uc h)) (* b (- vc k)) (* du u-lap)) dt))
            new-vc (+ vc (* (+ (* c (- vc h)) (* d (- vc k)) (* du v-lap)) dt))]
        (turing.update-cell u-grid j i new-uc)
        (turing.update-cell v-grid j i new-vc))))
  [u-grid v-grid])

turing
