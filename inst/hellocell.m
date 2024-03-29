## Copyright (C) 2009 Riccardo Corradini <riccardocorradini@yahoo.it>
## Copyright (C) 2012 Carlo de Falco
##
## This program is free software; you can redistribute it and/or modify it under
## the terms of the GNU General Public License as published by the Free Software
## Foundation; either version 3 of the License, or (at your option) any later
## version.
##
## This program is distributed in the hope that it will be useful, but WITHOUT
## ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
## FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
## details.
##
## You should have received a copy of the GNU General Public License along with
## this program; if not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {Function File} {} = hellocell ()
## This function demonstrates sending and receiving a string message over MPI.
## Each process will send a message to process with rank 0, which will then display it.
## To run this example, set the variables HOSTFILE and NUMBER_OF_MPI_NODES to appropriate values, 
## then type the following command in your shell:
## @example
## mpirun --hostfile $HOSTFILE -np $NUMBER_OF_MPI_NODES octave --eval 'pkg load mpi; hellocell ()'
## @end example
## @seealso{hello2dimmat,helloworld,hellosparsemat,hellostruct,mc_example,montecarlo,Pi} 
## @end deftypefn

function hellocell ()

  MPI_Init ();
  ## the string NEWORLD is just a label could be whatever you want 
  CW = MPI_Comm_Load ("NEWORLD");

  my_rank = MPI_Comm_rank (CW);
  p = MPI_Comm_size (CW);

  ## TAG is very important to identify the message
  TAG = 1;

  if (my_rank != 0)
    message = {magic(3) 17 'fred'; ...
               'AliceBettyCarolDianeEllen' 'yp' 42; ...
               {1} 2 3};
    rankvect = 0;
    [info] = MPI_Send (message, rankvect, TAG, CW);
  else
    for source = 1:p-1
      disp ("We are at rank 0 that is master etc..");
      [messagerec, info] = MPI_Recv (source, TAG, CW);
      info
      messagerec
    endfor
  endif   

  MPI_Finalize ();
  
endfunction

%!demo
%! system ("mpirun --hostfile $HOSTFILE -np $NUMBER_OF_MPI_NODES octave -q --eval 'pkg load mpi; hellocell ()'");

