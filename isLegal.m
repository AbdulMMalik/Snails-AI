function [ islegal, movement ] = isLegal(board, x, y, turn)
    
    movement = 'wrongMove';
    if turn == 22
        myMark = 2;
    else
        myMark = 1;
    end
    
    [xx, yy] = find (board == turn);
    if (x > 8 || x < 1 || y > 8 || y < 1)
         islegal = false;
         return;
    end
    %down movement
    if ((x == xx+1 && y == yy) && (board(x, y) == 0 || board(x, y) == myMark))
        islegal = true;
        movement = 'down';
        return;
    end
    %right movement
    if ((x == xx && y == yy+1) && (board(x, y) == 0 || board(x, y) == myMark))
        islegal = true;
        movement = 'right';
        return;
    end
    %up movement
    if ((x == xx-1 && y == yy) && (board(x, y) == 0 || board(x, y) == myMark))
        islegal = true;
        movement = 'up';
        return;
    end
    %left movement
    if ((x == xx && y == yy-1) && (board(x, y) == 0 || board(x, y) == myMark))
        islegal = true;
        movement = 'left';
        return;
    end
    
    %code for long jump
    
    %horizontal jump
    if ( x == xx && y > yy) %horizontal jump toward right
        for i = (yy + 1):y
            if(board(x, i) ~= myMark)
                islegal = false;
                return;
            end
        end
        islegal = true;
        movement = 'right';
        return;
    end
    if (x == xx && y < yy) %horizontal jump left
        for i = y:(yy - 1)
            if(board(x, i) ~= myMark)
                islegal = false;
                return;
            end
        end 
        islegal = true;
        movement = 'left';
        return;
    end
    
    %vertical jump
    if (y == yy && x > xx) %jump down 
        for i = (xx + 1):x
            if(board(i, y) ~= myMark)
                islegal = false;
                return;
            end
        end
        islegal = true;
        movement = 'down';
        return;
    end
    
    if (y == yy && x < xx) %jump up 
        for i = x:(xx - 1)
            if(board(i, y) ~= myMark)
                islegal = false;
                return;
            end
        end
        islegal = true;
        movement = 'up';
        return;
    end
    islegal = false;
end
