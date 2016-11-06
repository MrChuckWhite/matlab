function message = lsb_read_zz(image, msg_length)
    
    %traverse in zig-zag fashion
    moveleft = false;
    moveright = false;
    shiftdown = false;
    shiftright = false;
    lock = false;  % lock after a shift takes place. Reset after a move
    finished = false; 
    
    i = 1;
    j = 1;
    
    len = length(image);
    msg = '';
    
    while ~finished 
            
        %action for i,j
        pxl = dec2bin(image(i,j));
        steg_bit = pxl(end);
        
        msg = strcat(msg, steg_bit);
        
        %terminate condition
        if i == len && j == len
            finished = true;
            break;
        end
        
        if length(msg)/8 > msg_length
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

    text = '';
    msg_len = length(msg);
    for i=1:8:msg_len-8
       byte = msg(i:i+7); 
       byte = char(bin2dec(byte));
       text = strcat(text, byte);
        
    end
    message = text;
end