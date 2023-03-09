(local turing (require :turing))

(local color-multiplier 25)

(local fdt 0.01) ; Fixed dt

(local columns 100)
(local rows 100)
(local pixel-size 10)

(var experiment-index 1)
(var experiments [])

(fn build-experiment [parameters]
  {:grid (turing.build-grid-with-noise columns rows)
   :parameters parameters
   :iteration 0})

(fn current-experiment []
  (. experiments experiment-index))

(fn love.load []
  (set experiments [(build-experiment {:a 1 :b -1 :c 2 :d -1.5 :h 1 :k 1 :du 0.0001 :dv 0.0006})]))

(fn love.update [dt]
  (let [experiment (current-experiment)
        iteration (+ (. experiment :iteration) 1)
        grid (. experiment :grid)
        parameters (. experiment :parameters)]
    (tset experiment :iteration iteration)
    (tset experiment :grid (turing.update grid parameters fdt))))

(fn love.draw []
  (local experiment (current-experiment))
  (local grid (. experiment :grid))
  (local iteration (. experiment :iteration))
  (for [x 1 columns]
    (for [y 1 rows]
      (let [{: u : v } (turing.cell grid x y)
            blue (math.max (math.min (* color-multiplier u) 255) 0)
            red (math.max (math.min (* color-multiplier v) 255) 0)]
        (love.graphics.setColor (love.math.colorFromBytes red 0 blue))
        (love.graphics.rectangle "fill"
                                 (* (- x 1) pixel-size)
                                 (* (- y 1) pixel-size)
                                 pixel-size
                                 pixel-size))))
  (if (= iteration 100000)
    (love.graphics.captureScreenshot (.. "pattern-" iteration ".png"))))
