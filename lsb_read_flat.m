function message = lsb_read_flat(image, msg_length)

    finished = false; 
    
    i = 1;
    j = 1;
    
    len = length(image);
    msg = '';
    
    while i < len && ~finished
        while j < len && ~finished

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
            
            j = j + 1;
        end
        i = i + 1;
    end

    text = '';
    msg_len = length(msg);
    for i=1:8:msg_len-8
       byte = msg(i:i+7); 
       byte = char(bin2dec(byte));
       text = strcat(text, byte);
        
    message = text;
end