#!/opt/freeware/rexx/bin/rexx
/*#################################################################################*/
/*#                                                                               #*/
/*# Script Name: net_ios.rexx                                                     #*/
/*#                                                                               #*/
/*# Description: xxxxxxxxxxxxxxxxxxxx script                                      #*/
/*#                                                                               #*/
/*# Modified:                                                                     #*/
/*#                                                                               #*/
/*#  2013.07.04 SAL_SUM:60948                                                     #*/
/*#             created by root                                                   #*/
/*#                                                                               #*/
/*# Licensed Materials - Property of LG CNS                                       #*/
/*#                                                                               #*/
/*# (C) COPYRIGHT LG CNS Co., Ltd. 2009                                           #*/
/*# All Rights Reserved                                                           #*/
/*#                                                                               #*/
/*#################################################################################*/
            
  parse arg p1

  qd = '"'
  qs = "'"      /*  PSTOPNGLN2V_130704_net.nmon */
  infile  = p1  /* infile:  PSTOPNGLN2V_130704_net.nmon */
                /* outfile: HOSTNAMEXXX_yymmdd_netios.nmon */
  vcnt_max = 0
  vcnt_min = 999999999999         
           /*  m  g  t  p */
  r_max    = 0
  w_max    = 0


  parse var infile xx '_net.nmon'
  outfile = xx'_netios.nmon'

  if ( exists(infile) ) then do

     ADDRESS SYSTEM 'cat 'infile with output stem out.
     /* -- record 2 : veriable count */
     x=2; call v_cnt_rtn

     v_tmp = out.2
     do i = 1 to v_cnt
        parse var v_tmp v.i ',' tail; v_tmp = tail
     end

     v_read = ''; v_write = ''
     do i = 3 to v_in + 2
        j = i + v_in
        v_read  = v_read ||v.i'+'
        v_write = v_write||v.j'+'
     end
     v_out2tmp = v.1','v.2','v_read','v_write',inbound:'v_in'/outbound:'v_in

     do x = 3 to out.0

        call v_cnt_rtn

        v_tmp = out.x
        do i = 1 to v_cnt
           parse var v_tmp v.i ',' tail; v_tmp = tail
        end

        v_read = 0; v_write = 0
        do i = 3 to v_in + 2 
           j = i + v_in
           if ( datatype(v.i) = 'NUM' ) then do 
           v_read  = v_read  + v.i
           v_write = v_write + v.j
           end
           else do
              say i v.i '##'v_cnt'###' x out.x
           end
        end
        if ( r_max < v_read ) then r_max = v_read
        if ( w_max < v_write) then w_max = v_write
        v_out.x = v.1','v.2','v_read','v_write

     end
   
     v_out.0 = out.0
     v_out.1 = out.1
     v_out.2 = v_out2tmp',read_max:'r_max'/wirte_max:'w_max

     ADDRESS SYSTEM 'cat > 'outfile with input stem v_out.
     /* ------------- 
     do i = 1 to v_out.0
        say v_out.i
     end     
        ------------- */

  end

  exit 

v_cnt_rtn:
  v_tmp = TRANSLATE(out.x,'+',' ')  /* to <plus>  <-- from <space> */
  v_tmp = TRANSLATE(v_tmp,' ',',')  /* to <space> <-- from <comma> */ 
  v_cnt = words(v_tmp)
  v_in  = ( v_cnt - 2 ) / 2
  if ( vcnt_max < v_cnt ) then vcnt_max = v_cnt
  if ( vcnt_min > v_cnt ) then vcnt_min = v_cnt
return 

exists:
  parse arg p1
  EXEC_CMD = 'if [ -f 'p1' ] ; then echo "found"; else echo "not_found"; fi '
  ADDRESS SYSTEM EXEC_CMD with output stem out.
  if ( out.1 = 'found' ) then return 1 /* true  */
                         else return 0 /* false */
return

/*# SAL_SUM:60948:2013.07.16 Do not delete this line */
