(local t (require :fspec))

(local experiment (require :experiment))

;; Test generate-parameters
(let [parameters (experiment.generate-parameters {:a [0 2 1]
                                                  :b [1 2 1]
                                                  :c [1 1 0]})]
  (t.items-eq (. parameters 1) {:a 0 :b 1 :c 1})
  (t.items-eq (. parameters 2) {:a 0 :b 2 :c 1})
  (t.items-eq (. parameters 3) {:a 1 :b 1 :c 1})
  (t.items-eq (. parameters 2) {:a 1 :b 2 :c 1})
  (t.items-eq (. parameters 2) {:a 2 :b 1 :c 1})
  (t.items-eq (. parameters 2) {:a 2 :b 2 :c 1}))
