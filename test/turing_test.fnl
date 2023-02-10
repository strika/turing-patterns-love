(local t (require :fspec))

(local turing (require :turing))

;; Test build-grid

(let [grid (turing.build-grid 2 3)]
  (t.is-table grid)
  (for [i 1 2]
    (for [j 1 3]
      (let [v (. grid i j)]
        (t.neq v 1)
        (t.true (> v 0.97))
        (t.true (< v 1.03))))))

;; Test rows

(let [grid (turing.build-grid 2 3)]
  (t.eq 2 (turing.rows grid)))

;; Test columns

(let [grid (turing.build-grid 2 3)]
  (t.eq 3 (turing.columns grid)))

(t.run!)
