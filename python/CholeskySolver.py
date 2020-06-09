"""Cholesky Linear Solver Bench

This script allows the user to bench scipy's cholesky linear solver.

This tool accepts Matrix Market files (.mtx).

This script requires that `scipy` and 'memory-profiler` to be installed within the Python
environment you are running this script in.

This script looks for all the .mtx files inside the matrixes folder that is placed in the root
of the project.
The mtx file is read and then the size is extracted to generate the exact solution vector made
(xe = [1 1 1 1 ... 1 1],a perf_counter time is then acquired and the computation is started inside
a memory profiler to evaluate the impact on the memory, then the relative error between the result
and the exact result is computed.

This file can also be imported as a module and contains the following
functions:

    * solveSystem - returns the solution of the linear system
    * main - the main function of the script
    *writeCsv - an helper function that writes the bench data to a csv file

"""

import csv
import time
import os
from sksparse.cholmod import cholesky
from scipy.linalg import norm
from scipy.io import mmread
from numpy import ones
from memory_profiler import memory_usage
from glob import glob


def solveSystem(A, xe):
    """Solves a linear sparse system using cholesky

        Parameters
        ----------
        A : coo_matrix
            The sparse matrix that is used as an input
        xe: ndarray
            The exact solution vector

        Returns
        -------
        x
            The solution vector
        """

    factor = cholesky(A)
    b = A * xe
    x = factor(b)
    return x


def writeCsv(filename, data, headers):
    """Write a result line on a csv file

        Parameters
        ----------
        filename : string
            The csv filename on which the results must be written
        data: Dict
            A dictionary containing th data that must be written
        headers: Array
            The headers of the csv

        """

    file_exists = os.path.isfile(filename)
    with open(filename, 'a') as csvfile:
        writer = csv.DictWriter(csvfile, delimiter=',', lineterminator='\n', fieldnames=headers)
        if not file_exists:
            writer.writeheader()

        writer.writerow(data)
        csvfile.close()

if __name__ == '__main__':
    for f in glob("../matrixes/*.mtx"):
        print('Starting with' + f)
        A = mmread(f)
        size = A.shape[0]
        xe = ones(size)
        start = time.perf_counter()
        (mem_usage, x) = memory_usage((solveSystem, (A.tocsc(), xe)), retval=True)
        stop = time.perf_counter()
        fntime = stop - start
        erel = norm(x - xe) / norm(xe)
        mem_usage = max(mem_usage)
        reportLine = {'Matrix': f, 'Size': size, 'MemoryUsage': mem_usage, 'Time': fntime, 'RelativeError': erel}
        writeCsv('report.csv', reportLine, [*reportLine])
