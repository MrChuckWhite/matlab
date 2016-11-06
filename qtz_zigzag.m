function matrix = qtz_zigzag(x, Q)
    len = length(x);
    
    matrix = zeros(len,len);
    
    moveleft = false;
    moveright = false;
    shiftdown = false;
    shiftright = false;
    lock = false;  % lock after a shift takes place. Reset after a move
    finished = false; 
    
    i = 1;
    j = 1;
    
    while ~finished 
            
        %action for i,j. Can replace with any operation for i,j
        matrix(i,j) = round((x(i,j) * 16) / (Q(i,j) * 16));

        %terminate 
        if i == len
            if j == len
                finished = true;
                break;
            end
        end
        
        %shift down move right
        if j == 1 && ~lock
            moveleft = false;
            moveright = true;
            shiftright = false;
            shiftdown = true;
        end

        %shift right move left
        if i == 1 && ~lock
            moveleft = true;
            moveright = false;
            shiftright = true;
            shiftdown = false;
        end

        %shift right move right
        if i == len && ~lock
            moveleft = false;
            moveright = true;
            shiftright = true;
            shiftdown = false;
        end

        %shift down move left
        if j == len && ~lock
            moveleft = true;
            moveright = false;
            shiftright = false;
            shiftdown = true;
        end

        % action. shift right
        if shiftright && ~lock 
            j = j + 1;
            shiftright = false;
            lock = true;
            continue
        end

        %action. shift down
        if shiftdown && ~lock
            i = i + 1;
            shiftdown = false;
            lock = true;
            continue
        end

        % action. move left
        if moveleft == true
            i = i+1;
            j = j-1;
            lock = false;
        end

        % action. move right
        if moveright == true
            i = i - 1;
            j = j + 1;
            lock = false;
        end
    end
end