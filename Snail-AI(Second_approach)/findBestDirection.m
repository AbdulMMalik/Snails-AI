function best_direction = findBestDirection( best_movement )
    if best_movement == 1
        best_direction = 'up';
    else if best_movement == 2
            best_direction = 'right';
        else if best_movement == 3
                best_direction = 'down';
            else
                best_direction = 'left';
            end
        end
    end
end

