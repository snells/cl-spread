# cl-spread
Common lisp bindings for spread toolkit-4


### dependencies   
spread-toolkit version 4   
cffi   
cffi-libffi   
example.lisp uses bordeaux-threads


### Usage   
All the C functions are defined but only few are currently lispfied and exported in this library.


connect return a-list with connection info or nil if it fails.   
quit-con macro disconnects connection and sets the given connection to nil.


(defvar con (connect "user-name" "4803@localhost")   
(join con "my-group")   
(send "some message" "my-group")   
(receive-formatted-mess con)   
(quit-con con)   


### tested on   
linux x86_64   
sbcl 1.2.11   
spread-4.3.0


Should work with other common lisp implementations if cffi works in them.