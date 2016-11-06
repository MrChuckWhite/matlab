function steg = lsb_embed_flat(image, message)
    msg_len = length(message);
    
    m_bits_vec = dec2bin(message,8);
    m_bits = '';
    
    for i=1:msg_len
       m_bits = strcat(m_bits, m_bits_vec(i,:));
    end
    
    
    m_bit_counter = 1;
    len = length(image);
    
    finished = false;
    i = 1;
    j = 1;
    
    %traverse in flat fashion
    while i < len && ~finished
        while j < len && ~finished
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

            j = j + 1;
        end
        i = i + 1;

    end
    
    %return statement
    steg = image;
end
