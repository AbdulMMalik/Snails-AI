function [ bestBoard, score ] = findOptimalMove( board, turn, agentTurn, scoreAgent, scoreOpp )

    % generate all possible immidiate children
    [ children, scores ] = generateChildren( board, turn, agentTurn, scoreAgent, scoreOpp );
    [ r c l ] = size( children );
    maxScoreList = zeros(1, l);
    
    % find heuristic for all children
    for i=1:l
        [ maxScore, modifiedBoard ] = generateHeuristic( children(:, :, i), turn );
        children(:, :, i) = modifiedBoard;
        maxScoreList(1, i) = maxScore + scores(1, i);
    end
   
    % find children with maximum heuristic
    [ maxScore, index ] = max(maxScoreList);
    if maxScoreList(1, :) == maxScoreList(1, index)
        [ dummy, index ] = max(scores);
    end
    
    % return board which can give you the best heuristic with scores
    bestBoard = children(:, :, index);
    score = scores(1, index);
end

