#!/opt/freeware/rexx/bin/rexx
/*#################################################################################*/
/*#                                                                               #*/
/*# Script Name: net_ios.rexx                                                     #*/
/*#                                                                               #*/
/*# Description: xxxxxxxxxxxxxxxxxxxx script                                      #*/
/*#                                                                               #*/
/*# Modified:                                                                     #*/
/*#                                                                               #*/
/*#  2013.07.04 SAL_SUM:43489                                                     #*/
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
  qs = "'"       /* PSTOPNGLN2V_130704_diskr.nmon          */
  infile1  = p1  /* infile1: PSTOPNGLN2V_130704_diskr.nmon */
  infile2  = ''  /* infile2: PSTOPNGLN2V_130704_diskw.nmon */
  outfile  = ''  /* outfile: HOSTNAMEXXX_yymmdd_diskios.nmon */
  v1cnt_max = 0
  v1cnt_min = 999999999999         
           /*  m  g  t  p */
  v2cnt_max = 0
  v2cnt_min = 999999999999         
           /*  m  g  t  p */
  r_max    = 0
  w_max    = 0


  parse var infile1 xx '_diskr.nmon'
  infile2 = xx'_diskw.nmon'
  outfile = xx'_diskios.nmon'

  if ( exists(infile1) & exists(infile2) ) then do

     ADDRESS SYSTEM 'cat 'infile1 with output stem out1.
     ADDRESS SYSTEM 'cat 'infile2 with output stem out2.
     /* -- record 2 : veriable count */
     x=2; call v1_cnt_rtn; call v2_cnt_rtn;  /* x for v1_cnt_rtn */
                                             /* return:  v1cnt_max, v1cnt_min */
                                             /*          v2cnt_max, v2cnt_min */
     v1_tmp = out1.2; v2_tmp = out2.2;
     do i = 1 to v1_cnt   /* v1_cnt = v2_cnt : check skip */
        parse var v1_tmp v1.i ',' tail1; v1_tmp = tail1
        parse var v2_tmp v2.i ',' tail2; v2_tmp = tail2
     end

     v_read = ''; v_write = ''
     do i = 3 to v1_cnt   /* record 2: setting */ 
        v_read  = v_read ||v1.i'+'
        v_write = v_write||v2.i'+'
     end
     parse var v1.2 xx 'Read' yy; v1.2 = xx'DISKIOS'yy
     vv_out2tmp = 'DISKIOS,'v1.2','v_read','v_write',read:'v1_in'/write:'v2_out

                          /* out1.0 = out2.0  : check skip */
     do x = 3 to out1.0

        call v1_cnt_rtn; call v2_cnt_rtn;  /* v1_cnt = v2_cnt : check skip */
        v1_tmp = out1.x; v2_tmp = out2.x;
        do i = 1 to v1_cnt   /* v1_cnt = v2_cnt : check skip */
           parse var v1_tmp v1.i ',' tail1; v1_tmp = tail1
           parse var v2_tmp v2.i ',' tail2; v2_tmp = tail2
        end

        v_read = 0; v_write = 0
        do i = 3 to v1_cnt
           if ( datatype(v1.i) = 'NUM' & datatype(v2.i) = 'NUM' ) then do 
           v_read  = v_read  + v1.i
           v_write = v_write + v2.i
           end
           else do
              say i v1.i '##'v1_cnt'###' out1.x
              say i v2.i '##'v2_cnt'###' out2.x
           end
        end
        if ( r_max < v_read ) then r_max = v_read
        if ( w_max < v_write) then w_max = v_write
        vv_out.x = 'DISKIOS,'v1.2','v_read','v_write

     end
   
     vv_out.0 = out1.0
     vv_out.1 = out1.1
     vv_out.2 = vv_out2tmp',read_max:'r_max'/wirte_max:'w_max

     ADDRESS SYSTEM 'cat > 'outfile with input stem vv_out.
     /* ------------- 
     do i = 1 to v_out.0
        say v_out.i
     end     
        ------------- */

  end

  exit 

v1_cnt_rtn:
  v1_tmp = TRANSLATE(out1.x,'+',' ')  /* to <plus>  <-- from <space> */
  v1_tmp = TRANSLATE(v1_tmp,' ',',')  /* to <space> <-- from <comma> */ 
  v1_cnt = words(v1_tmp)
  v1_in  = v1_cnt - 2 
  if ( v1cnt_max < v1_cnt ) then v1cnt_max = v1_cnt
  if ( v1cnt_min > v1_cnt ) then v1cnt_min = v1_cnt
return 
v2_cnt_rtn:
  v2_tmp = TRANSLATE(out2.x,'+',' ')  /* to <plus>  <-- from <space> */
  v2_tmp = TRANSLATE(v2_tmp,' ',',')  /* to <space> <-- from <comma> */ 
  v2_cnt = words(v2_tmp)
  v2_out = v2_cnt - 2 
  if ( v2cnt_max < v2_cnt ) then v2cnt_max = v2_cnt
  if ( v2cnt_min > v2_cnt ) then v2cnt_min = v2_cnt
return 

exists:
  parse arg p1
  EXEC_CMD = 'if [ -f 'p1' ] ; then echo "found"; else echo "not_found"; fi '
  ADDRESS SYSTEM EXEC_CMD with output stem out.
  if ( out.1 = 'found' ) then return 1 /* true  */
                         else return 0 /* false */
return

/*# SAL_SUM:43489:2013.07.16 Do not delete this line */
