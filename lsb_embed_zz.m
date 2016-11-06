function steg = lsb_embed_zz(image, message)
    msg_len = length(message);
    
    m_bits_vec = dec2bin(message,8);
    m_bits = '';
    
    for i=1:msg_len
       m_bits = strcat(m_bits, m_bits_vec(i,:));
    end
    
    
    %traverse in zig-zag fashion
    moveleft = false;
    moveright = false;
    shiftdown = false;
    shiftright = false;
    lock = false;  % lock after a shift takes place. Reset after a move
    finished = false; 
    
    i = 1;
    j = 1;
    
    m_bit_counter = 1;
    len = length(image);
    
    while ~finished 
            
        %action for i,j
        pxl = dec2bin(image(i,j));
        steg_bit = m_bits(m_bit_counter);
        
        pxl(end) = steg_bit;
        pxl = bin2dec(pxl);
        image(i,j) = pxl;
        m_bit_counter = m_bit_counter + 1;
        
        
        %terminate condition
        if i == len && j == len
            finished = true;
            break;
        end
        
        if m_bit_counter > length(m_bits)
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
    
    %return statement
    steg = image;
end
