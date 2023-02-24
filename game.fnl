(local turing (require :turing))

(local fdt 0.01) ; Fixed dt

(local columns 100)
(local rows 100)
(local pixel-size 10)

(var iteration 0)

(var parameters nil)
(var u-grid nil)
(var v-grid nil)

(fn print-grid [grid]
  (for [x 1 10]
    (for [y 1 10]
      (print (turing.cell grid y x)))))

(fn love.load []
  (set parameters {:a 1 :b -1 :c 2 :d -1 :h 1 :k 1 :du 0.0001 :dv 0.0006})
  (set u-grid (turing.build-grid-with-noise columns rows))
  (set v-grid (turing.build-grid-with-noise columns rows)))

(fn love.update [dt]
  (set iteration (+ iteration 1))
  (if (= 0 (% iteration 100))
    (print "Iteration: " iteration))
  (let [[new-u-grid new-v-grid] (turing.update u-grid v-grid parameters fdt)]
    (set u-grid new-u-grid)
    (set v-grid new-v-grid)))

(fn love.draw []
  (for [x 1 columns]
    (for [y 1 rows]
      (let [u (turing.cell u-grid x y)
            v (turing.cell v-grid x y)
            blue (math.max (math.min u 255) 0)
            red (math.max (math.min v 255) 0)]
        (love.graphics.setColor (love.math.colorFromBytes red 0 blue))
        (love.graphics.rectangle "fill"
                                 (* (- x 1) pixel-size)
                                 (* (- y 1) pixel-size)
                                 pixel-size
                                 pixel-size)))))
