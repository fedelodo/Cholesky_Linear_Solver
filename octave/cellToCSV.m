function cellToCSV(fileName, cell)
    fid=fopen(fileName,'wt');

    try
      [rows,cols]=size(cell);
      for i=1:rows
          fprintf(fid,'%s;', cell{i,1:end-1});
          fprintf(fid,'%s\n', cell{i,end});
      end
    catch exception
      disp(exception.message);
    end_try_catch

    fclose(fid);
endfunction
