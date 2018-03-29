function [ maxScore, board ] = generateHeuristic( board, turn ) 

    % initialize variables
    maxScore = 0; 
    [x, y] = find(board == 0);
    
    % find opponent turn i-e not agent
    if turn == 11
        oppo_turn = 22;
    else
        oppo_turn = 11;
    end
    
    % find number of empty spaces in board
    [ length dummy ] = size([x, y]);
    % check distancea of every free block from agent and opponent
    for i=1:length
        [ snail_x, snail_y ] = find(board == turn); % finding position of snail
        % find how many steps agent is away from free block
        [ my_steps, possibility_1 ] = findStepDistance_dummy( board, [ snail_x, snail_y ], [x(i), y(i)], turn, 0, 0, 500, 0 );
        % if there exist a possible shortest path from agent to free block
        % saving first possibility
        pre_possibility_1 = possibility_1;
        if possibility_1 == 0
            % verifying that there is no block from free block to agent
            dummy_board = board;
            dummy_board( snail_x, snail_y ) = 0;
            dummy_board( x(i), y(i) ) = turn;
            % check path possibility from free block to snail
            [ my_steps, possibility_1 ] = findStepDistance_dummy( dummy_board, [x(i), y(i)], [ snail_x, snail_y ], turn, 0, 0, 500, 0 );
        end
        [ snail_x, snail_y ] = find(board == oppo_turn); % finding position of opponent snail
        % finding distance from opponent snail to free block
        [ oppo_steps, possibility_2 ] = findStepDistance_dummy( board, [ snail_x, snail_y ], [x(i), y(i)], oppo_turn, 0, 0, 500, 0 );
        % saving first possibility
        pre_possibility_2 = possibility_2;
        if possibility_2 == 0 % if there is no path from opponent snail to free block
            dummy_board = board;
            dummy_board( snail_x, snail_y ) = 0;
            dummy_board( x(i), y(i) ) = oppo_turn;
            % also check path possibility from free block to snail
            [ my_steps, possibility_2 ] = findStepDistance_dummy( dummy_board, [x(i), y(i)], [ snail_x, snail_y ], oppo_turn, 0, 0, 500, 0 );
        end
        
        % if there is no possible path for both snail to the free block
        % then this block comes under no territory
        % if pre_possibility_1 == 0 && pre_possibility_2 == 0
        %   board(x(i), y(i)) = -1;
        % else if possibility_1 == 0 && possibility_2 == 1 % if only opponent can reach
        %        board(x(i), y(i)) = floor(oppo_turn/10);
        %    else if possibility_1 == 1 && possibility_2 == 0 % if only agent can reach
        %        board(x(i), y(i)) = floor(turn/10);
        %        end
        %    end
        % end
        
        if my_steps <= oppo_steps && possibility_1 == 1
            maxScore = maxScore + 1;
        end
    end
end