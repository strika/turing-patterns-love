(local t (require :fspec))

(local turing (require :turing))

;; Test build-grid

(let [grid (turing.build-grid 3 2)]
  (t.is-table grid)
  (t.eq grid [[1 1 1]
              [1 1 1]]))

(t.run!)
