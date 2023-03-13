(local turing (require :turing))

(local color-multiplier 25)

(local fdt 0.01) ; Fixed dt

(local columns 100)
(local rows 100)
(local pixel-size 10)

(var experiment-end-iteration 100)
(var experiment-index 1)
(var experiments [])

(fn build-experiment [parameters]
  {:grid (turing.build-grid-with-noise columns rows)
   :parameters parameters
   :iteration 0})

(fn current-experiment []
  (. experiments experiment-index))

(fn generate-experiments []
  (set experiments [(build-experiment {:a 1 :b -1 :c 2 :d -1.5 :h 1 :k 1 :du 0.0001 :dv 0.0006})
                    (build-experiment {:a 0.98 :b -1 :c 2 :d -1.5 :h 1 :k 1 :du 0.0001 :dv 0.0006})
                    (build-experiment {:a 1.02 :b -1 :c 2 :d -1.5 :h 1 :k 1 :du 0.0001 :dv 0.0006})]))

(fn love.load []
  (generate-experiments)
  (with-open [experiment-log (io.open "experiments.log" :w)]
    (experiment-log:write "a,b,c,d,h,k,du,dv\n")))

(fn love.update [dt]
  (if (> experiment-index (length experiments))
    (do
      (print "Done.")
      (love.event.quit))
    (do
      (let [experiment (current-experiment)
            iteration (+ (. experiment :iteration) 1)
            grid (. experiment :grid)
            parameters (. experiment :parameters)]
        (tset experiment :iteration iteration)
        (tset experiment :grid (turing.update grid parameters fdt))
        (if (> iteration experiment-end-iteration)
          (set experiment-index (+ experiment-index 1)))))))

(fn love.draw []
  (if (<= experiment-index (length experiments))
    (do
      (local experiment (current-experiment))
      (local grid (. experiment :grid))
      (local iteration (. experiment :iteration))
      (print iteration)
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
      (if (= iteration experiment-end-iteration)
        (do
          (let [params (. experiment :parameters)
                details (.. (. params :a) ","
                            (. params :b) ","
                            (. params :c) ","
                            (. params :d) ","
                            (. params :h) ","
                            (. params :k) ","
                            (. params :du) ","
                            (. params :dv) "\n")]
            (love.graphics.captureScreenshot (.. "experiment-" experiment-index "-iteration-" iteration ".png"))
            (with-open [experiment-log (io.open "experiments.log" :a)]
              (experiment-log:write details))))))))
