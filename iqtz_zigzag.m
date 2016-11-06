function matrix = iqtz_zigzag(x, Q)
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
            
        %action for i,j
        matrix(i,j) = x(i,j) * Q(i,j);
        %disp(x(i,j)); 

        %terminate 
        if i == len && j == len
            finished = true;
            break;
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

        %shift right
        if shiftright && ~lock 
            j = j + 1;
            shiftright = false;
            lock = true;
            continue
        end

        %shift down
        if shiftdown && ~lock
            i = i + 1;
            shiftdown = false;
            lock = true;
            continue
        end

        % move left
        if moveleft == true
            i = i+1;
            j = j-1;
            lock = false;
        end

        % move right
        if moveright == true
            i = i - 1;
            j = j + 1;
            lock = false;
        end
    end
end