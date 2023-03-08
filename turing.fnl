;;; Turing Patterns

(local turing {})

(local neighbourhood-coordinates [[-1 0] [1 0] [0 -1] [0 1]])

(fn turing.noise []
  (let [c (* (math.random) 0.03)]
    (if (> (math.random) 0.5)
      c
      (- 0 c))))

(fn turing.build-cell []
  {:u 1 :v 1})

(fn turing.build-cell-with-noise []
  {:u (+ 1 (turing.noise))
   :v (+ 1 (turing.noise))})

(fn turing.build-grid-with-noise [columns rows]
  (fcollect [i 1 rows]
    (fcollect [j 1 columns]
      (turing.build-cell-with-noise))))

(fn turing.build-grid [columns rows]
  (fcollect [i 1 rows]
    (fcollect [j 1 columns]
      (turing.build-cell))))

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

(fn turing.update-cell [grid column row u v]
  (tset grid row column :u u)
  (tset grid row column :v v))

(fn turing.neighbourhood [grid column row]
  (accumulate [cell {:u 0 :v 0}
               _ [dr dc] (ipairs neighbourhood-coordinates)]
    (let [neighbour (turing.cell grid (+ column dc) (+ row dr))]
      {:u (+ (. cell :u) (. neighbour :u))
       :v (+ (. cell :v) (. neighbour :v))})))

(fn turing.update [grid new-grid parameters dt]
  (local {: a : b : c : d : h : k : du : dv} parameters)
  (local rows (turing.rows grid))
  (local columns (turing.columns grid))
  (local dh (/ 1 rows))
  (for [i 1 rows]
    (for [j 1 columns]
      (let [cell (turing.cell grid j i)
            uc (. cell :u)
            vc (. cell :v)
            neighbourhood (turing.neighbourhood grid j i)
            u-lap (/ (- (. neighbourhood :u) (* 4 uc)) (* dh dh))
            v-lap (/ (- (. neighbourhood :v) (* 4 vc)) (* dh dh))
            new-uc (+ uc (* (+ (* a (- uc h)) (* b (- vc k)) (* du u-lap)) dt))
            new-vc (+ vc (* (+ (* c (- uc h)) (* d (- vc k)) (* dv v-lap)) dt))
            new-uc (math.max (math.min new-uc 255) 0)
            new-vc (math.max (math.min new-vc 255) 0)]
        (turing.update-cell new-grid j i new-uc new-vc))))
  [grid new-grid])

turing
