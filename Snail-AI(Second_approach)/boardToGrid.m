function grid = boardToGrid(board)
    [rows, cols] = size(board);
    size_rows = rows * 100;
    size_cols = cols * 100;
    
    %read images
    grid = imread('boardImage.jpg');
    turn1 = imread('snail1.jpg');
    turn2 = imread('snail2.jpg');
    snail1_mark = imread('snail1_mark.jpg');
    snail2_mark = imread('snail2_mark.jpg');
    no_mark = imread('no_mark.jpg');
    
    %place icon of second player
    [x, y] = find(board == 22);
    x = (x * 100) - 100;
    y = (y * 100) - 100;
    if x == 0
        x = x + 1;
    end
    if y == 0
        y = y + 1;
    end
    
    %place icon
    grid(x:(x-1) + 100, y:y+100, :) = turn2(1:100, 1:101, :);
    
    %place icon of first player
    [x, y] = find(board == 11);
    x = (x * 100) - 100;
    y = (y * 100) - 100;
    if x == 0
        x = x + 1;
    end
    if y == 0
        y = y + 1;
    end
    %place icon
    grid(x:(x-1) + 100, y:y+100, :) = turn1(1:100, 1:101, :);
    
    %find marks of first players
    [ x, y ] = find(board == 1);
    [ numberOfMarks, dummy ] = size(x);
    %place marks on grid
    for i = 1:numberOfMarks
        x_Cord = x(i); y_Cord = y(i);
        x_Cord = (x_Cord * 100) - 100;
        y_Cord = (y_Cord * 100) - 100;
        if x_Cord == 0
            x_Cord = x_Cord + 1;
        end
        if y_Cord == 0
            y_Cord = y_Cord + 1;
        end
        %place icon
        grid(x_Cord:(x_Cord-1) + 100, y_Cord:y_Cord+100, :) = snail1_mark(1:100, 1:101, :);
    end
    
    %find marks of second players
    [ x, y ] = find(board == 2);
    [ numberOfMarks, dummy ] = size(x);
    %place marks on grid
    for i = 1:numberOfMarks
        x_Cord = x(i); y_Cord = y(i);
        x_Cord = (x_Cord * 100) - 100;
        y_Cord = (y_Cord * 100) - 100;
        if x_Cord == 0
            x_Cord = x_Cord + 1;
        end
        if y_Cord == 0
            y_Cord = y_Cord + 1;
        end
        %place icon
        grid(x_Cord:(x_Cord-1) + 100, y_Cord:y_Cord+100, :) = snail2_mark(1:100, 1:101, :);
    end
    
    % find place where no player can reach
    [ x, y ] = find(board == -1);
    [ numberOfMarks, dummy ] = size(x);
    %place marks on grid
    for i = 1:numberOfMarks
        x_Cord = x(i); y_Cord = y(i);
        x_Cord = (x_Cord * 100) - 100;
        y_Cord = (y_Cord * 100) - 100;
        if x_Cord == 0
            x_Cord = x_Cord + 1;
        end
        if y_Cord == 0
            y_Cord = y_Cord + 1;
        end
        %place icon
        grid(x_Cord:(x_Cord-1) + 100, y_Cord:y_Cord+100, :) = no_mark(1:100, 1:101, :);
    end
    
    %draw lines or make board
    printLine = 100;
    for i = 1:rows-1
        %draw vertical lines
        printLineColumn = printLine * i;
        grid(:, printLineColumn, :) = 0;
        grid(:, (printLineColumn+1), :) = 255;
        grid(:, (printLineColumn+2), :) = 255;
        grid(:, (printLineColumn+3), :) = 255;
        
        %draw horizontal lines
        printLineRow = printLine * i;
        grid(printLineRow, :, :) = 255;
        grid((printLineRow+1), :, :) = 255;
        grid((printLineRow+2), :, :) = 255;
        grid((printLineRow+3), :, :) = 255;
    end
end