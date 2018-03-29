function [ tempX, tempY ] = slideSnail( board, x, y, turn, movement )
    if turn == 22
        myMark = 2;
    else
        myMark = 1;
    end
    tempX = x; tempY = y; isSlide = false;
    
    %if need to slide down
    if strcmp(movement, 'down') == 1
        while board(tempX, tempY) == myMark
            isSlide = true;
            tempX = tempX + 1;
            if tempX == 9
                break;
            end
        end
        if isSlide
            tempX = tempX - 1;
        end
        return;
    end
    %if need to slide up
    if strcmp( movement, 'up') == 1
        while board(tempX, tempY) == myMark
            isSlide = true;
            tempX = tempX - 1;
            if tempX == 0
                break;
            end
        end
        if isSlide
            tempX = tempX + 1;
        end
        return;
    end
    
    %if need to slide right
    if strcmp( movement, 'right') == 1
        while board(tempX, tempY) == myMark
            isSlide = true;
            tempY = tempY + 1;
            if tempY == 9
                break;
            end
        end
        if isSlide
            tempY = tempY - 1;
        end
        return;
    end
    
    %if need to slide left
    if strcmp( movement, 'left') == 1
        while board(tempX, tempY) == myMark
            isSlide = true;
            tempY = tempY - 1;
            if tempY == 0
                break;
            end
        end
        if isSlide
            tempY = tempY + 1;
        end
        return;
    end
end