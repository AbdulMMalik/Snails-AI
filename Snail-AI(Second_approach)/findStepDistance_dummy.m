function [ steps, possibility ] = findStepDistance_dummy( board, snail, free_block, turn, CLOSE_LIST, steps, depth, N )

    if depth == 0 || steps > 20
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
        return;
    end
    
    distances = zeros(1, 1);
    rows = zeros(1, 1);
    cols = zeros(1, 1);
    indexes = zeros(1, 1);
    
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
        indexes(1, i) = i;
        distances(1, i) = distance;
        rows(1, i) = row;
        cols(1, i) = col;
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

     %[ dummy, index ] = min(distances);
    % distances = sort(distances);
    [ distances, rows, cols ] = sortDistances(distances, rows, cols);
    [ dummy, length ] = size(distances);
    for index = 1:length
        
        %if index ~= 1
        %    if distances(1, index - 1) ~= distances(1, index)
        %        possibility = 0;
        %        return;
        %    end
            %disp('index has changed');
            %index
        %end
        % based on best movement number find direction
        best_movement = MOVEMENTS(1, index);
        best_direction = findBestDirection( best_movement );

        dummy_board = board;
        [ row, col ] = slideSnail( dummy_board, rows(1, index), cols(1, index), turn, best_direction );
        dummy_board(row, col) = turn;
        if turn == 11
            dummy_board(snail_x, snail_y) = 1;
        else
            dummy_board(snail_x, snail_y) = 2;
        end
        dummy_steps = steps + 1;

        dummy_snail = [row, col]; % update position of snail
        % call this function again to find shortest path
        dummy_depth = depth - 1;
        dummy_N = N + 1;
        [ dummy_steps, possibility ] = findStepDistance_dummy(dummy_board, dummy_snail, free_block, turn, CLOSE_LIST, dummy_steps, dummy_depth, dummy_N);
        
        % if there exists a path to reach to the destination
        if possibility == 1
            steps = dummy_steps;
            return;
        else
            if N == 0 % if it is a parent node then check another child for possibility
                continue;
            else % else move toward parent i-e back recurrsion
                possibility = 0;
                steps = dummy_steps;
                return;
            end
           
        end
    end
    % if we donot find any possiblity to reach to the destination
    possibility = 0;
    return;
end

function [ distances, rows, cols ] = sortDistances(distances, rows, cols)
    
    [ dummy, length ] = size(distances);
    for i=1:length
        for j=i+1:length
            if distances(1, i) > distances(1, j)
                dummy = distances(1, i);
                distances(1, i) = distances(1, j);
                distances(1, j) = dummy;
                
                dummy = rows(1, i);
                rows(1, i) = rows(1, j);
                rows(1, j) = dummy;
                
                dummy = cols(1, i);
                cols(1, i) = cols(1, j);
                cols(1, j) = dummy;                
            end
        end
    end
end