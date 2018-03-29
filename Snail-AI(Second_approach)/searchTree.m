function [ nextBoard, value, myScore ] = searchTree(board, turn, agentTurn, depth, scoreAgent, scoreOpp)

    myScore = 0;
    [ score ] = gameStatus( board, agentTurn );
    if ( score == 10 || score == -10 || depth == 0 )
        nextBoard = board;
        if turn ~= agentTurn
            myScore = scoreOpp;
            value = scoreOpp;
        else
            myScore = scoreAgent;
            value = scoreAgent;
        end
        
        maxScore = generateHeuristic( board, turn );
        value = value + maxScore + score; 
        return;
    end
    
    [ children, scores ] = generateChildren( board, turn, agentTurn, scoreAgent, scoreOpp );
    depth = depth - 1;
    [ r c l ] = size( children );
    valuesList = zeros(1, l);
    %change turn because move has changed now
    nextTurn = changeTurn( turn );       

    for i=1:l
        % nextTurn = changeTurn( turn );
        if nextTurn ~= agentTurn
            [ bestBoard, resultValue, NaN ] = searchTree( children(:, :, i), nextTurn, agentTurn, depth, scores(1, i), scoreOpp );
        else
            [ bestBoard, resultValue, NaN ] = searchTree( children(:, :, i), nextTurn, agentTurn, depth, scoreAgent, scores(1, i) );
        end
        valuesList(1, i) = resultValue;
    end
    
    if( turn == agentTurn )
        [ min_max_score, dummy ] = max(scores);
        [ min_max_value, index ] = max(valuesList);
    else
        [ min_max_score, dummy ] = max(scores);
        [ min_max_value, index ] = max(valuesList);
    end
    nextBoard = children(:, :, index);
    myScore = min_max_score;
    value = min_max_value; 
end

