%call initialize board
rows = 8; cols = 8;
board = initializeBoard(rows, cols);
board(1, 8) = 22;
board(8, 1) = 11;
grid = boardToGrid( board );


imshow( grid );

turn = 11;
agentTurn = 22;
depth = 5;

while 1
   if(turn == 11)
      [x, y] = ginput(1);
      temp = y;
      y = floor(x/100)+1;
      x = floor(temp/100)+1;
      
      [xx, yy] = find (board == 11);
      [ islegal, movement ] = isLegal(board, x, y, 11);
      if ( islegal == false )
          msgbox('Invalid Input', 'Error','error')    
      else
          board(xx, yy) = 1;
          %check sliding
          [ x, y ] = slideSnail( board, x, y, turn, movement );
          board(x, y) = 11;
          turn = changeTurn(turn);
      end
   else
      [ board, value ] = searchTree(board, turn, agentTurn, depth);
      turn = changeTurn(turn);
       %{
       [x, y] = ginput(1);
       temp = y;
       y = floor(x/100)+1;
       x = floor(temp/100)+1;
       [xx, yy] = find (board == 22);
       [ islegal, movement ] = isLegal(board, x, y, 22);
       if ( islegal == false )
           msgbox('Invalid Input', 'Error','error')
       else
           board(xx, yy) = 2;
           %check sliding
           [ x, y ] = slideSnail( board, x, y, turn, movement );
           board(x, y) = 22;
           turn = changeTurn(turn);
       end
       %}
   end
   
   grid = boardToGrid(board);
   imshow(grid);
   
   score = gameStatus( board, agentTurn );
   if score ==  10 || score == -10
       if score == 10
           disp('agent won');
       else
           disp('opponent won');
       end
       break;
   end
end