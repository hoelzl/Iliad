;;; -*- Mode: Lisp; common-lisp-style: poem -*-

;;; Copyright (c) 2013 Matthias Hölzl
;;;
;;; This file is licensed under the MIT license; see the file LICENSE in the root directory for
;;; further information.

(in-package #:poem-bootstrap)

(defun get-package-external-symbols (package-name &optional (ignored-symbols '()))
  (let ((result '())
        (package (find-package package-name)))
    (assert package (package) "No package named ~A." package-name)
    (do-external-symbols (symbol package)
      (unless (member symbol ignored-symbols
                      :test (lambda (s1 s2)
                              (string-equal (symbol-name s1) (symbol-name s2))))
        (push symbol result)))
    result))

(defun as-strings (symbols)
  (mapcar (lambda (symbol)
            (symbol-name symbol))
          symbols))

(defun as-uninterned-symbols (strings)
  (mapcar (lambda (string)
            (make-symbol string))
          strings))

(defun package-external-symbol-names (package-name &optional (ignored-symbols '()))
  (sort (as-strings (get-package-external-symbols package-name ignored-symbols))
        #'string-lessp))

(defun package-external-symbols (package-name &optional (ignored-symbols '()))
  (as-uninterned-symbols (package-external-symbol-names package-name ignored-symbols)))

(defun package-exports-name (package-name)
  (assert (symbolp package-name) ()
          "Package name must be a symbol, is ~A" package-name)
  (intern (format nil "*~A-~A*" package-name '#:package-exports)))

(defmacro define-package-exports (package-name &rest ignored-symbols)
  `(defparameter ,(package-exports-name package-name)
     ',(package-external-symbol-names package-name ignored-symbols)))

