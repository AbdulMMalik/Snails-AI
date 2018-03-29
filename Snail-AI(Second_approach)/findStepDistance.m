function [ steps, possibility ] = findStepDistance( board, snail, free_block, turn, CLOSE_LIST, steps, depth )

    if depth == 0
        possibility = 0;
        return;
    end
    OPEN_LIST = zeros(1, 1); % maintains list where snail can move
    %STEP_DISTANCE = zeros(1, 1); % distance of each neighbour block to free block
    MAX_MOVEMENTS = 4; % maximum number of movements that a snail can have
    MOVEMENTS = zeros(1, 1);
    
    % get snail coordinates
    snail_x = snail(1, 1);
    snail_y = snail(1, 2);
    
    % get coordinates of free blocks
    free_block_x = free_block(1, 1);
    free_block_y = free_block(1, 2);
    
    % check all possible movements
    while MAX_MOVEMENTS ~= 0
        if MAX_MOVEMENTS == 4 % check up movment
            x = snail_x - 1; y = snail_y;   
        else if MAX_MOVEMENTS == 3 % checks right movement
                x = snail_x; y = snail_y + 1;
        else if MAX_MOVEMENTS == 2 % check down movement
                x = snail_x + 1; y = snail_y;
            else  % check left movement
                x = snail_x; y = snail_y - 1;
            end
            end
        end
        
        [ islegal, movement ] = isLegal(board, x, y, turn);
        [ checkSlide_x, checkSlide_y ] = slideSnail(board, x, y, turn, movement);
        block_number = (checkSlide_x - 1)*8 + checkSlide_y;
        member = ismember(block_number, CLOSE_LIST);
        if member == 1 % if it is not already visited
            islegal = false;
        end
        if islegal % if it is a valid move
            %if we have reached to the destination
            if (x == free_block_x) && (y == free_block_y)
                possibility = 1;
                steps = steps + 1;
                return;
            end
            
            % need to increse the size of open list if we get one more
            % possible move
            [ dummy length ] = size(OPEN_LIST);
            if OPEN_LIST(1, length) ~= 0
                length = length + 1;
            end
            
            % calculate block number and place it into the open list
            block_number = (x - 1)*8 + y;
            member = ismember(block_number, CLOSE_LIST);
            if member == 0 % if it is not already visited
                OPEN_LIST(1, length) = block_number;
                if strcmp(movement, 'up') == 1
                    MOVEMENTS(1, length) = 1;
                else if strcmp(movement, 'right') == 1
                        MOVEMENTS(1, length) = 2;
                    else if strcmp(movement, 'down') == 1
                            MOVEMENTS(1, length) = 3;
                        else
                            MOVEMENTS(1, length) = 4;
                        end
                    end
                end
            end
        end
        MAX_MOVEMENTS = MAX_MOVEMENTS - 1;
    end
    
    % if there is no possible way to reach ot a particular coordinate
    if OPEN_LIST(1, 1) == 0
        possibility = 0;
        board
        return;
    end
    
    % find optimal next block to get benifit of sliding as well
    [ dummy length ] = size(OPEN_LIST); 
    for i=1:length
        minStepDistanceBlock = OPEN_LIST(1, i);
        best_movement = MOVEMENTS(1, i); % finding best movement number based on index
        row = ceil(minStepDistanceBlock/8); % getting row number of that block
        col = minStepDistanceBlock - (row - 1) * 8;% getting column number of that block        
        
        best_direction = findBestDirection( best_movement );
        [ row, col ] = slideSnail( board, row, col, turn, best_direction );
        %calculate minimum steps taken from x, y to free_x, free_y
        step_x = free_block_x - row; 
        step_y = free_block_y - col;
            
        %if step_x < 0 
        %   step_x = step_x * (-1); 
        %end
        %    
        %if step_y < 0
        %  step_y = step_y * (-1);
        %end
        
        distance = sqrt(step_x * step_x + step_y * step_y); % total steps distance
        if i == 1
            index = i;
            previous_step_distance = distance;
            previous_row = row;
            previous_col = col;
        end
        
        if previous_step_distance > distance
            index = i;
            previous_step_distance = distance; % total steps distance
            previous_row = row;
            previous_col = col;
        end
    end
    
    % add snail coorinate into visited or close list blocks
    [ dummy, length ] = size( CLOSE_LIST );
    snail_block_number = (snail_x - 1) * 8 + snail_y;
    if CLOSE_LIST(1, length) == 0
        CLOSE_LIST(1, 1) = snail_block_number;
    else
        length = length + 1;
        CLOSE_LIST(1, length) = snail_block_number;
    end

    % based on best movement number find direction
    best_movement = MOVEMENTS(1, index);
    best_direction = findBestDirection( best_movement );
    
    [ row, col ] = slideSnail( board, previous_row, previous_col, turn, best_direction );
    board(row, col) = turn;
    if turn == 11
        board(snail_x, snail_y) = 1;
    else
        board(snail_x, snail_y) = 2;
    end
    steps = steps + 1;
    
    snail = [row, col]; % update position of snail
    % call this function again to find shortest path
    depth = depth - 1;
    [ steps, possibility ] = findStepDistance(board, snail, free_block, turn, CLOSE_LIST, steps, depth);
end