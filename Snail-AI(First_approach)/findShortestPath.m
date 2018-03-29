function stepDistance = findShortestPath( board, agentTurn )
    [ snail_x, snail_y ] = find( board == agentTurn );
    if agentTurn == 22
        [ opp_x, opp_y ] = find( board == 11 );
    else
        [ opp_x, opp_y ] = find( board == 22 );
    end
    
    diff_x = opp_x - snail_x;
    if diff_x < 0
        diff_x = diff_x * -1;
    end
    
    diff_y = opp_y - snail_y;
    if diff_y < 0
        diff_y = diff_y * -1;
    end
    
    stepDistance = ( diff_x + diff_y );
end

