(local t (require :fspec))

(local experiment (require :experiment))

;; Test generate-parameters
(let [parameters (experiment.generate-parameters {:a [0 2 1]
                                                  :b [1 2 1]
                                                  :c [1 1 1]})]
  (t.items-eq parameters [{:a 0 :b 1 :c 1}
                          {:a 0 :b 2 :c 1}
                          {:a 1 :b 1 :c 1}
                          {:a 1 :b 2 :c 1}
                          {:a 2 :b 1 :c 1}
                          {:a 2 :b 2 :c 1}]))

(let [parameters (experiment.generate-parameters {:a [1 2 1]
                                                  :b [1 1 1]})]
  (t.items-eq parameters [{:a 1 :b 1}
                          {:a 2 :b 1}]))
