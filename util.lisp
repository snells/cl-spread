(in-package :cl-spread)
(defvar pointers '())

(defun quit (&optional code)
      ;; This group from "clocc-port/ext.lisp"
      #+allegro (excl:exit code)
      #+clisp (#+lisp=cl ext:quit #-lisp=cl lisp:quit code)
      #+cmu (ext:quit code)
      #+cormanlisp (win32:exitprocess code)
      #+gcl (lisp:bye code)                     ; XXX Or is it LISP::QUIT?
      #+lispworks (lw:quit :status code)
      #+lucid (lcl:quit code)
      #+sbcl (sb-ext:exit :code code)
      ;; This group from Maxima
      #+kcl (lisp::bye)                         ; XXX Does this take an arg?
      #+scl (ext:quit code)                     ; XXX Pretty sure this *does*.
      #+(or openmcl mcl) (ccl::quit)
      #+abcl (cl-user::quit)
      #+ecl (si:quit)
      ;; This group from <hebi...@math.uni.wroc.pl>
      #+poplog (poplog::bye)                    ; XXX Does this take an arg?
      #-(or allegro clisp cmu cormanlisp gcl lispworks lucid sbcl
            kcl scl openmcl mcl abcl ecl)
      (error 'not-implemented :proc (list 'quit code))) 


(defmacro def-pt-ref-macro (type)
  `(progn (defun ,(intern
		   (string-upcase
		    (format nil "REF-~a" type))) (pt)
	    (mem-ref pt ,type))
	  (defun (setf ,(intern
			 (string-upcase
			  (format nil "REF-~a" type)))) (val pt)
	    (setf (mem-ref pt ,type) val))))

(defun ref-c-array (pt type y x)
  (mem-aref (mem-aref pt :pointer y) type x))
(defun (setf ref-c-array) (val pt type y x)
  (setf (mem-aref (mem-aref pt :pointer y) type x) val))
(defmacro def-pts-from-list (lst)
  `(progn ,@(mapcar (lambda (item)
		      `(def-pt-ref-macro ,item))
		    lst)))
(defun define-pt-refs ();&optional type-list)
  (def-pts-from-list (:int :short :double :float :char :uint :int16)))

(unless (fboundp 'ref-int) (define-pt-refs))

(defun free (&rest pts)
  (dolist (pt pts)
    (foreign-free pt)))

(defun alloc (type &optional (count 1))
  (foreign-alloc type :count count))

(defmacro with-pts (lst &rest body)
  `(let ,(mapcar (lambda (l) `(,(car l) (alloc ,(cadr l) (if ,(caddr l) ,(caddr l) 1)))) lst)
     (progn ,@body)
     (free ,@(mapcar #'car lst))))



(defun make-struct (symbol type &key (vals nil) (count 1))
  (unwind-protect
       (handler-case
	   (let ((pt (alloc type count))
		 (names (foreign-slot-names type)))
	     (dotimes (x (length vals))
	       (let* ((val (nth x vals))
		      (slot (if (null (cdr val))
				(nth x names)
				(car val)))
		      (v (if (null (cdr val))
			     (car val)
			     (cadr val))))
		 (set-struct-val pt type slot v)))
	     (push (cons symbol pt) pointers)
	     pt)
	 (error (e)
	   (format t "error ~a~%" e)
	   (free-pointer symbol)))))
(defmacro with-struct ((symbol type &key (vals nil) (count 1)) &rest body)
  (let* ((symb (gensym))
	 (pt (make-struct symb type :vals vals :count count)))
    `(let ((,symbol ,pt))
       (progn ,@body)
       (free-pointer ,pt))))


(defun get-from-pointers (key)
  (if (pointerp key)
      (rassoc key pointers :test #'pointer-eq)
      (assoc key pointers)))
(defun get-pointer (key)
  (cdr (get-from-pointers key)))

(defun free-pointer (key)
  (when (get-pointer key)
    (free (get-pointer key))
    (setf pointers (remove (get-from-pointers key) pointers))))



(defun find-words (str)
	   (do ((counter 0 (1+ counter))
		(res "")
		(lst '()))
	       ((= counter (length str)) (nreverse (push res lst)))
	     (let ((obj (elt str counter)))
	       (if (or (char= obj #\ )
		       (char= obj #\Space)
		       (char= obj #\Tab))
		   (if (string/= "" res) (prog1 (push res lst) (setf res "")))
		   (setf res (concatenate 'string res (string obj)))))))
