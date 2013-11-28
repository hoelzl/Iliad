;;;; iliad.asd

(asdf:defsystem #:iliad-tests
  :serial t
  :description "Tests for Iliad"
  :version "0.0.1"
  :author "Matthias Hoelzl <tc@xantira.com>"
  :license "MIT, see file LICENSE"
  :depends-on (#:iliad #:screamer-tests)
  :components ((:module "Tests"
                :components ((:file "run-tests")))))

