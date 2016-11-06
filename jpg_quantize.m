function a = jpg_quantize(x,Q)

    len = length(x);

    a = zeros(len,len);

    for i = 1:len
        for j = 1:len
           a(i,j) = round((x(i,j) * 16) / (Q(i,j) * 16));
        end
    end 
end