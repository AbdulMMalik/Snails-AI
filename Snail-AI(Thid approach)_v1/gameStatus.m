function [ score ] = gameStatus( board, agentTurn )
    [ x dummy ] = find(board == 0);
    [ length dummy ] = size(x);
    
    if length > 0
        score = 5;
        return;
    end
    
    if agentTurn == 22
        [ x dummy ] = find(board == 2);
    end
    [ agentScore dummy ] = size(x);
    agentScore = agentScore + 1;
    opponentScore = 64 - agentScore;
    
    if agentScore > opponentScore
        score = 10;
        return;
    else
        score = -10;
        return;
    end
end