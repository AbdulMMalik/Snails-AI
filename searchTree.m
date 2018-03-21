function [ nextBoard, value ] = searchTree(board, turn, agentTurn, depth)

    [ score ] = gameStatus(board, agentTurn);
    if ( score == 10 || score == -10 || depth == 0)
        nextBoard = board;
        stepDistance = findShortestPath( board, agentTurn );
        value = score + ( 1/stepDistance );
        return;
    end
    
    children = generateChildren(board, turn);
    depth = depth - 1;
    [ r c l ] = size(children);
    valuesList = zeros(1, l);
           
    for i=1:l
        nextTurn = changeTurn( turn );
        [ bestBoard, resultValue ] = searchTree( children(:, :, i), nextTurn, agentTurn, depth );
        valuesList(1, i) = resultValue;
    end
    
    turn
    valuesList
    if( turn == agentTurn )
        [ min_max index ] = max(valuesList);
    else
        [ min_max index ] = min(valuesList);
    end
    nextBoard = children(:, :, index);
    value = min_max; 
end

