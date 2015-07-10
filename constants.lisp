(in-package :cl-spread)



(defconstant +ACCEPT-SESSION+      1)
(defconstant +ILLEGAL-SPREAD+ -1)
(defconstant +COULD-NOT-CONNECT+ -2)
(defconstant +REJECT-QUOTA+ -3)
(defconstant +REJECT-NO-NAME+ -4)
(defconstant +REJECT-ILLEGAL-NAME+ -5)
(defconstant +REJECT-NOT-UNIQUE+ -6)
(defconstant +REJECT-VERSION+ -7)
(defconstant +CONNECTION-CLOSED+ -8)
(defconstant +REJECT-AUTH+ -9) 
(defconstant +ILLEGAL-SESSION+ -11)
(defconstant +ILLEGAL-SERVICE+ -12)
(defconstant +ILLEGAL-MESSAGE+ -13)
(defconstant +ILLEGAL-GROUP+ -14)
(defconstant +BUFFER-TOO-SHORT+ -15)
(defconstant +GROUPS-TOO-SHORT+ -16)
(defconstant +MESSAGE-TOO-LONG+ -17) 
(defconstant +NET-ERROR-ON-SESSION+ -18)



(defconstant +UNRELIABLE-MESS+   #x00000001) 
(defconstant +RELIABLE-MESS+   	#x00000002 ) 
(defconstant +FIFO-MESS+       	#x00000004 ) 
(defconstant +CAUSAL-MESS+     	#x00000008 ) 
(defconstant +AGREED-MESS+     	#x00000010 ) 
(defconstant +SAFE-MESS+       	#x00000020 ) 



(defconstant		+LOW-PRIORITY+	0                                         ) 
(defconstant		+MEDIUM-PRIORITY+	1				  ) 
(defconstant		+HIGH-PRIORITY+	2					  ) 
(defconstant		+DEFAULT-SPREAD-PORT+	4803				  ) 
(defconstant         +SPREAD-VERSION+        (logior (ash 4 24) (ash 3 16) 0)   ) 
					;( (4 << 24) | ( 3 << 16) | 0 )		  
;(defconstant		+MAX-GROUP-NAME+		32			  ) 
  (defconstant         +MAX-PRIVATE-NAME+        10 				  ) 
(defconstant         +MAX-PROC-NAME+           20 				  ) 

(defconstant         +UNRELIABLE-MESS+         #x00000001			  ) 
(defconstant         +RELIABLE-MESS+           #x00000002			  ) 
(defconstant         +FIFO-MESS+               #x00000004			  ) 
(defconstant         +CAUSAL-MESS+             #x00000008			  ) 
(defconstant         +AGREED-MESS+             #x00000010			  ) 
(defconstant         +SAFE-MESS+               #x00000020			  ) 
(defconstant         +REGULAR-MESS+            #x0000003f			  ) 

(defconstant		+SELF-DISCARD+		#x00000040			  ) 
(defconstant         +DROP-RECV+               #x01000000			  ) 

(defconstant         +REG-MEMB-MESS+           #x00001000			  ) 
(defconstant         +TRANSITION-MESS+         #x00002000			  ) 
(defconstant		+CAUSED-BY-JOIN+		#x00000100		  ) 
(defconstant		+CAUSED-BY-LEAVE+		#x00000200		  ) 
(defconstant		+CAUSED-BY-DISCONNECT+	#x00000400			  ) 
(defconstant		+CAUSED-BY-NETWORK+	#x00000800			  ) 
(defconstant         +MEMBERSHIP-MESS+         #x00003f00			  ) 

(defconstant         +ENDIAN-RESERVED+        #x80000080			  ) 
(defconstant         +RESERVED+                #x003fc000			  ) 
(defconstant         +REJECT-MESS+             #x00400000               	  )
