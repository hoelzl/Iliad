;;; -*- Mode: Lisp; common-lisp-style: poem -*-

;;; Copyright (c) 2012-2013 Matthias Hölzl
;;; 
;;; This file is licensed under the MIT license; see the file LICENSE in the root directory for
;;; further information.


(in-package #:poem)

(defun ask (formula &rest args &key (reasoner :snark) &allow-other-keys)
  (ask-reasoner formula reasoner args))

(defgeneric ask-reasoner (formula reasoner args))

(defmethod ask-reasoner ((formula list) (reasoner (eql :snark)) args)
  ;; TODO: parse formula and translate to Snark representation
  (apply #'snark::new-prove formula (remove-from-plist args :reasoner)))

(defun tell (formula &rest args &key (reasoner :snark) &allow-other-keys)
  (tell-reasoner formula reasoner args))

(defgeneric tell-reasoner (formula reasoner args))

(defmethod tell-reasoner ((formula list) (reasoner (eql :snark)) args)
  (apply #'snark-user::assert formula (remove-from-plist args :reasoner)))
